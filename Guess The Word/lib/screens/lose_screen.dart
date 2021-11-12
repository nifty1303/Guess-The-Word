import 'package:flutter/material.dart';
import '../screens/game_screen.dart';
import '../screens/type_word_screen.dart';

class LoseScreen extends StatelessWidget {
  static const String routeName = '/lose-screen';


  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String word = data['word'];
    final int score = data['score'];
    final String guessedWord = data['guessedWord'];


    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "YOU LOST , Try again!",
              textAlign: TextAlign.center,
              style:
              theme.textTheme.headline1.copyWith(color: theme.primaryColor,fontSize: 40.0),
            ),


            Text(
              "Word : $guessedWord",
              textAlign: TextAlign.center,
              style:
              theme.textTheme.headline1.copyWith(color: theme.primaryColor,fontSize: 24.0),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              splashColor: theme.primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/", (route) => false);
              },
              child: FittedBox(
                child: Text("Main Menu", style: theme.textTheme.headline5),
              ),
              color: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ), SizedBox(height: 15,),
            FlatButton(
              splashColor: theme.primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
                onPressed: () => Navigator.pushReplacementNamed(context, word=="" ? GameScreen.routeName : TypeWordScreen.routeName,arguments: "")  ,
              child: FittedBox(
                child: Text("Play Again", style: theme.textTheme.headline5),
              ),
              color: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ],
        ),
      ),
    );
  }
}
