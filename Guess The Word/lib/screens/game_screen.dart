import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangman/http/random_word.dart';
import 'package:hangman/screens/win_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alphabel_letter.dart';
import '../models/game.dart';
import '../screens/lose_screen.dart';
import '../models/guess_letter_model.dart';
import '../widgets/guess_letter.dart';
import '../widgets/letter_click.dart';

class GameScreen extends StatefulWidget {
  static const routeName = "/game";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  Timer _timer;

  final RandomWord _randomWordApi = RandomWord();
  final Game game = Game(time: 30,score: 0,lives: 10, word: "Hangman");

  //random word letters
  List<GuessLetterModel> guessedLetters = List();
  //alphabet
  List<AlphabetLetter> clickAlphabetLetters = List();

  //------------------| Start timer |---------------------
  void startTime(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(this.game.time<=0)
          lose();
        else
          this.game.time--;
      });
    });
  }
  //=======================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.accentColor,
      body: SafeArea(
        child: guessedLetters.isEmpty
            ? Center(
                child: Text(
                  "Generating word...",
                  style: theme.textTheme.headline6
                      .copyWith(fontSize: 32.0, color: theme.primaryColor),
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    height: deviceHeight * 0.2,
                    width: double.infinity,
                    color: theme.primaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "lives : ${this.game.lives}",
                            style: theme.textTheme.headline5,
                          ),
                        ),SizedBox(width: 25.0,),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Image.asset(
                              'assets/images/${10-game.lives}.png',
                            ),
                          ),
                        ),SizedBox(width: 25.0,),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "0:${this.game.time<10 ? "0":""}${this.game.time}",
                            style: theme.textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: deviceHeight * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Wrap(
                      children: [
                        //setup word in guessLetter widget
                        ...this
                            .guessedLetters
                            .map((letter) =>
                                GuessLetter(letter.title, letter.isGuessed))
                            .toList()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        //show alphabet
                        ...this.clickAlphabetLetters.map((letter) =>
                          LetterClick(letter.title,letter.isChoose,letter.isContainsInWord,alphabetLetterClick)
                        ).toList()
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  //----------------| Get random word or word from user typing|---------------------
  Future getWord(BuildContext context) async {
    try{
      String routeWord = (ModalRoute.of(context).settings.arguments as String);
      if(routeWord==""){
        Map map = await _randomWordApi.getWord();
        setState(() => this.game.word = map['word']);
      }else{
        setState(() => this.game.word = routeWord);
      }

      setState(() {
        for (int i = 0; i < this.game.word.length; i++){
          guessedLetters.add(GuessLetterModel(this.game.word[i], false));
        }

        //if word contains space mark it as guessed
        guessedLetters.forEach((element) => element.title==" " ? element.isGuessed = true : element.isGuessed = false);
        getAlphabet();
      });


      startTime();
    }catch(e){}
  }

  //========================================================

  //----------------| get alphabel and setup it into list |---------------------
  void getAlphabet() => setState(() => AlphabetLetter.alphabet.forEach((letter) => this.clickAlphabetLetters.add(AlphabetLetter(letter.toUpperCase(),false,this.game.word.contains(letter)))));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      getWord(context);
    });
  }
  @override
  void dispose() {
    super.dispose();
    if(_timer!=null)
      _timer.cancel();
  }

  //---------------------| handle alphabet letter click |------------------------------
  void alphabetLetterClick(String title){
    bool isContains = false;
    setState(() {
      //set letter as guessed
      for (int i = 0; i < this.game.word.length; i++){
        if(this.game.word[i].toUpperCase() == title){
          guessedLetters[i].isGuessed = true;
          this.game.score += this.game.time;
          isContains = true;
        }
      }
      this.clickAlphabetLetters.where((letter) => letter.title==title).toList()[0].isChoose = true;

      //bad letter click - not contains in the word
      if(!isContains) this.game.lives--;

      //game lose
      if(this.game.lives<=0)
       lose();

      //reset time
      this.game.time = 30;

      //win the game
      if(guessedLetters.where((element) => element.isGuessed==false).isEmpty) win();
    });
  }
  //====================================================================================

  //lose game
  void lose() => Navigator.pushReplacementNamed(context, LoseScreen.routeName,arguments: {
    "score": this.game.score,
    "word" : (ModalRoute.of(context).settings.arguments as String),
    "guessedWord" : game.word
  });

  //win game
  void win() {
    checkHighScore();
    Navigator.pushReplacementNamed(context, WinScreen.routeName,arguments: {
      "score": this.game.score,
      "word" : (ModalRoute.of(context).settings.arguments as String),
      "guessedWord" : game.word
    });
  }



  //---------------------| Check if the game score is higher than the actual highscore |-------------------------------
  Future checkHighScore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(this.game.score >= (_prefs.getInt("highScore") ?? 0))
      await _prefs.setInt("highScore",this.game.score);
  }
  //===================================================================================================================

}
