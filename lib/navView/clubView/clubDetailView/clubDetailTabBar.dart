import 'package:flutter/material.dart';

import '../../../functionCollection.dart';
import '../../../main.dart';
import 'clubDetailBoard.dart';
import 'clubDetailCalendar.dart';
import 'clubDetailChat.dart';
import 'clubDetailHome.dart';

clubDetailTabBarView({required TabController controller, required dynamic result}) {
  return Container(
    child: [
      ClubDetailHome(result),
      ClubDetailBoard(),
      ClubDetailCalendar(),
      ClubDetailChat(),
    ][controller.index],
  );
}

class ClubDetailTabBar extends StatelessWidget implements PreferredSizeWidget {
  ClubDetailTabBar({required this.controller, required this.isMember}) : preferredSize = Size.fromHeight(38.0);
  @override
  final Size preferredSize;
  final TabController controller;
  final bool isMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffededed), width: 1),
        color: Colors.white
      ),
      child: TabBar(
        onTap: (index) {
          if(isMember == false) {
            showAlertDialog(context, '모임을 가입해주세요.');
            controller.index = controller.previousIndex;
          }
        },
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
      )
    );
  }
}