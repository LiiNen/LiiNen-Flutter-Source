import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/functionCollection.dart';

import 'clubSettingView/clubSettingView.dart';

class ClubDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  ClubDetailAppBar({required this.title, required this.isPresident, required this.result}) : preferredSize = Size.fromHeight(40.0);
  @override
  final Size preferredSize;
  final String title;
  final bool isPresident;
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {Navigator.pop(context);},
              child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
            ),
            Text(title, style: textStyle(weight: 700, size: 16.0)),
            isPresident ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {navigatorPush(context: context, widget: ClubSettingView(result));},
              child: Icon(Icons.settings, size: 24, color: Colors.black),
            ) : SizedBox(width: 24)
          ]
        )
      ),
    );
  }
}