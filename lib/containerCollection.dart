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
      child: Center(child: Container(
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        child: Text(_title, style: textStyle(weight: 700, size: 16.0), textAlign: TextAlign.left,)
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
  MainViewAppBar({this.home = false, this.title = '', this.back = false, this.preferredSize = const Size.fromHeight(40.0)});
  @override
  final Size preferredSize;

  final bool home;
  final String title;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: back ? IconButton(
        padding: EdgeInsets.only(left: 0),
        icon: Icon(Icons.arrow_back, color: Colors.black,),
        onPressed: () {Navigator.pop(context);},
      ) : null,
      title: home ? SvgPicture.asset('asset/image/splashLogo.svg', width: 81, height: 16)
        : Text(title, style: textStyle(weight: 700, size: 16.0)),
    );
  }
}

class VerticalLineDivider extends StatelessWidget {
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