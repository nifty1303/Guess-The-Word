import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScoreScreen extends StatelessWidget {
  static const routeName = '/highscore-screen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("High Score")),
      backgroundColor: theme.accentColor,
      body: FutureBuilder<dynamic>(
          future: getHighScore(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      snapshot.hasData
                          ? Text(
                              "Your high score: ${snapshot.data.toString()}",
                              style: theme.textTheme.headline1.copyWith(
                                  color: theme.primaryColor, fontSize: 28),
                            )
                          : SizedBox(
                              child: CircularProgressIndicator(
                                backgroundColor: theme.primaryColor,
                              ),
                              width: 60,
                              height: 60,
                            ),
                    ]),
              )),
    );
  }

  //--------------| Get current user highscore |----------------
  Future getHighScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('highScore' ?? 0);
  }
//=============================================================
}
