import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LetterClick extends StatelessWidget {

  //---------------------| Alphabet letter widget |--------------------------

  final String title;
  final bool isChoose;
  final bool isContainsInWord;
  final Function letterClick;

  LetterClick(this.title,this.isChoose,this.isContainsInWord,this.letterClick);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: isChoose ? null : () => letterClick(this.title),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3,vertical: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: this.isChoose ? this.isContainsInWord ? Colors.greenAccent[100] : Colors.redAccent[100] : Colors.deepPurple[500],
        ),
        width: deviceHeight*0.06,
        height: deviceHeight*0.06,
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
          this.title,style: theme.textTheme.headline6.copyWith(fontSize: 30.0,color: this.isChoose ? this.isContainsInWord ? Colors.green[900] : Colors.white : Colors.white,),
          ),
        ),
      ),
    );
  }
}
