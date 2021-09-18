import 'package:flutter/material.dart';

class ClubDetailTabBar extends StatelessWidget implements PreferredSizeWidget {
  ClubDetailTabBar({required this.controller, required this.title}) : preferredSize = Size.fromHeight(58.0);
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
      title: Text(title),
      bottom: TabBar(
        controller: controller,
        indicatorColor: Colors.black,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0),
          insets: EdgeInsets.symmetric(horizontal: 44.0)
        ),
        labelColor: Colors.black,
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