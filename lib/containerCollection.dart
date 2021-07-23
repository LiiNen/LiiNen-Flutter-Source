import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  final String _title;
  TitleContainer(this._title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(child: Container(
        padding: EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width,
        child: Text(_title, textAlign: TextAlign.left,)
      ))
    );
  }
}