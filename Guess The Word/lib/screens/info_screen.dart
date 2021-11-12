import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  static const String routeName = "/info";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.accentColor,
      appBar: AppBar(
        title: Text("App Info"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            "Simple hangman app. Play alone with the words randomized from the random word website api. Also play with your friend and type him your own word!",style: theme.textTheme.headline5.copyWith(color: theme.primaryColor),textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
