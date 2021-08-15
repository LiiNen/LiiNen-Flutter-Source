import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/main.dart';

import 'functionCollection.dart';

class TitleContainer extends StatelessWidget {
  final String _title;
  TitleContainer(this._title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16 * responsiveScale),
      height: 56 * responsiveScale,
      child: Center(child: Container(
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        child: Text(_title, style: textStyle(weight: 700, size: 20.0), textAlign: TextAlign.left,)
      ))
    );
  }
}

class LoginViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  LoginViewAppBar() : preferredSize = Size.fromHeight(48.0);
  @override
  final Size preferredSize;

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
}

class MainViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainViewAppBar() : preferredSize = Size.fromHeight(40.0);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: Colors.lightGreen,
      title: Center(
        child: SvgPicture.asset('asset/image/splashLogo.svg', width: 81, height: 16)
      )
    );
  }
}

class ColumnVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffd1d5d9),
          width: 1
        )
      )
    );
  }
}