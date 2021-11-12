import 'package:flutter/material.dart';


class GuessLetter extends StatelessWidget {

  //------------| The word letter widget _ - not guessed letter A-guessed letter |-------------

  final String title;
  final bool isGuessed;
  GuessLetter(this.title,this.isGuessed);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        children: [
          Text(isGuessed ? this.title : "",style: theme.textTheme.headline6.copyWith(fontSize: 24.0),),
          Container( color: title!=" " ? theme.primaryColor: Colors.transparent, width: 30,height: 2,)
        ],
      ),
    );
  }
}
