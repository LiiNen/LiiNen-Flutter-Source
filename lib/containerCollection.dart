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

class LoginViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.only(left: 0),
        icon: Icon(Icons.arrow_back, color: Colors.black,),
        onPressed: () {Navigator.pop(context);},
      ),
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: const Color(0xffffffff)
    );
  }

  LoginViewAppBar() : preferredSize = Size.fromHeight(48.0);
  @override
  final Size preferredSize;
}