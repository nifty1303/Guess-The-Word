import 'package:flutter/material.dart';
import './screens/info_screen.dart';
import './screens/type_word_screen.dart';
import './screens/high_score_screen.dart';
import './screens/win_screen.dart';
import './screens/game_screen.dart';
import './screens/lose_screen.dart';
import './screens/main_menu_screen.dart';

void main() {
  runApp(Hangman());
}

class Hangman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guess The Word',
      theme: ThemeData(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.white,
          fontFamily: "ArchitectsDaughter",
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(fontSize: 70.0),
              headline5: TextStyle(fontSize: 24.0, color: Colors.black),
              headline6: TextStyle(fontSize: 18.0, color: Colors.black))),
      initialRoute: "/",
      routes: {
        '/' : (context) => MainMenu(),
        GameScreen.routeName : (context) => GameScreen(),
        LoseScreen.routeName : (context) =>LoseScreen(),
        WinScreen.routeName : (context) => WinScreen(),
        HighScoreScreen.routeName : (context) => HighScoreScreen(),
        TypeWordScreen.routeName : (context) => TypeWordScreen(),
        InfoScreen.routeName : (context) => InfoScreen()
      },
    );
  }
}
