import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';
import 'package:hangman/screens/type_word_screen.dart';

class WinScreen extends StatelessWidget {
  static const routeName = "/win-screen";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String word = data['word'];
    final int score = data['score'];
    final String guessedWord = data['guessedWord'];

    return Scaffold(
      backgroundColor: theme.accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congrats! You have won!",
              style:
                  theme.textTheme.headline1.copyWith(color: theme.primaryColor),
            ),

            SizedBox(
              height: 12,
            ),
            Text(
              "Word : $guessedWord",
              textAlign: TextAlign.center,
              style: theme.textTheme.headline1
                  .copyWith(color: theme.primaryColor, fontSize: 24.0),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              splashColor: theme.primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () => Navigator.pushReplacementNamed(context,
                  word == "" ? GameScreen.routeName : TypeWordScreen.routeName,
                  arguments: ""),
              child: FittedBox(
                child: Text("Play Again",
                    style: theme.textTheme.headline6
                        .copyWith(color: theme.accentColor)),
              ),
              color: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              splashColor: theme.primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (route) => false),
              child: FittedBox(
                child: Text("Main Menu",
                    style: theme.textTheme.headline6
                        .copyWith(color: theme.accentColor)),
              ),
              color: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
