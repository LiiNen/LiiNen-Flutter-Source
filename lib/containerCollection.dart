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
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: const Color(0xffffffff),
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(children: [
        Positioned(
          bottom: 8, left: 21,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
          ),
        )
      ]),
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
      automaticallyImplyLeading: false,
      title: home ? SvgPicture.asset('asset/image/splashLogo.svg', width: 81, height: 16)
        : Text(title, style: textStyle(weight: 700, size: 16.0)),
      flexibleSpace: Stack(
        children: back ? [
          Positioned(
            bottom: 8, left: 21,
            child: GestureDetector(
              onTap: () {Navigator.pop(context);},
              child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
            ),
          )
        ] : []
      )
    );
  }
}

class LineDivider extends StatelessWidget {
  LineDivider({this.color = const Color(0xffebebeb)});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 1
        )
      )
    );
  }
}