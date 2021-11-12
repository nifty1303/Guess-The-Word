import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';


class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.accentColor,
        body: Column(
          mainAxisSize:MainAxisSize.max ,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                "Guess the Word",
                textAlign: TextAlign.center,
                style: theme
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.blueAccent),
              ),
            ),SizedBox( height: deviceHeight*0.1),
            Container(
              color: theme.primaryColor,
              child: Column(
                mainAxisAlignment:    MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: FlatButton(
                            splashColor: theme.primaryColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () => Navigator.pushNamed(context, GameScreen.routeName,arguments: "")
                            ,
                            child: FittedBox(
                              child: Text("Play",style: theme
                                  .textTheme
                                  .headline6),
                            ),
                            color: Colors.blue,
                            padding:const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                          ),
                        ),
                      ),

                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
            )
          ],
        ));
  }
}
