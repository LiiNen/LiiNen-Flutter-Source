import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/main.dart';

import 'functionCollection.dart';

class TitleContainer extends StatelessWidget {
  final String title;
  final double size;
  final bool margin;

  TitleContainer({required this.title, this.size=16.0, this.margin=true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16 * responsiveScale),
      child: Center(child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin ? 21 * responsiveScale : 0),
        width: MediaQuery.of(context).size.width,
        child: Text(title, style: textStyle(weight: 700, size: size), textAlign: TextAlign.left,)
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
          bottom: 8, left: 21 * responsiveScale,
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
            bottom: 8, left: 21 * responsiveScale,
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
  LineDivider({this.color = const Color(0xffebebeb), this.horizontalMargin = true});
  final Color color;
  final bool horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin ? 21 * responsiveScale : 0),
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

categoryItem(String title, bool condition) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      border: Border.all(color: condition ? selectedBorderColor() : unselectedBorderColor()),
      color: condition ? selectedFillColor() : unselectedFillColor()
    ),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
      child: Text(title, style: textStyle(color: condition ? selectedTextColor() : unselectedTextColor(), weight: 400, size: 14.0),)
    )
  );
}

confirmButton({required title, required confirmAction, required condition}){
  return GestureDetector(
    onTap: () {confirmAction();},
    child: Container(
      height: 52,
      width: maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: condition ? Color(0xff0958c5) : Color(0xffd1d5d9),
      ),
      child: Center(child: Text(title, style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
    )
  );
}

checkBoxWithText ({required context, required title, required condition, required tapAction}) {
  TextStyle style = textStyle(color: Color(0xff636c73), weight: 400, size: 14.0);
  return GestureDetector(
    onTap: () {tapAction();},
    child: Container(
      height: 24,
      width: maxWidth,
      child: Row(
        children: [
          Container(
            width: 24 * responsiveScale, height: 24 * responsiveScale,
            child: SvgPicture.asset(condition
              ? 'asset/image/checkBoxCheck.svg'
              : 'asset/image/checkBoxUncheck.svg'),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            width: MediaQuery.of(context).size.width - 98 * responsiveScale,
            child: Text(title, style: style),
          ),
        ],
      )
    )
  );
}

class ExitDialog extends StatefulWidget {
  @override
  State<ExitDialog> createState() => _ExitDialog();
}
class _ExitDialog extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: exitBox()
    );
  }

  exitBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 112,
            child: Center(
              child: Text('앱을 종료하시겠습니까?', style: textStyle(weight: 400, size: 16.0))
            )
          ),
          IntrinsicHeight(
            child: Container(
              height: 52,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  actionBox(false),
                  actionBox(true),
                ]
              )
            )
          )
        ]
      )
    );
  }

  actionBox(bool action) {
    return Expanded(child: Container(
      child: GestureDetector(
        onTap: () {
          action ? SystemNavigator.pop() : Navigator.of(context).pop(false);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffebebeb), width: 1),
            color: Color(0xfffbfbfb),
          ),
          child: Center(
            child: Text(action ? '확인' : '취소', style: textStyle(color: Color(0xff0958c5), weight: 600, size: 14.0))
          )
        )
      ),
    ));
  }
}
