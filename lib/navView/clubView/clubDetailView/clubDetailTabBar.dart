import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/functionCollection.dart';

import '../../../main.dart';

class ClubDetailTabBar extends StatelessWidget implements PreferredSizeWidget {
  ClubDetailTabBar({required this.controller, required this.title}) : preferredSize = Size.fromHeight(78.0);
  @override
  final Size preferredSize;
  final TabController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,

      title: Text('코딩할 사람 모여라', style: textStyle(weight: 700, size: 16.0)),
      bottom: TabBar(
        controller: controller,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1.0, color: Color(0xff0958c5)),
        ),
        labelColor: Color(0xff0958c5),
        labelStyle: textStyle(color: Color(0xff0958c5), weight: 600, size: 14.0),
        unselectedLabelColor: Color(0xffd1d5d9),
        unselectedLabelStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 14.0),
        tabs: [
          Tab(text: '홈'),
          Tab(text: '게시판'),
          Tab(text: '퀘스트'),
          Tab(text: '캘린더'),
        ]
      ),
      flexibleSpace: Stack(children: [
        Positioned(
          top: 52, left: 21 * responsiveScale,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
          ),
        )
      ]),
    );
  }
}