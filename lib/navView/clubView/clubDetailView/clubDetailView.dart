import 'package:flutter/material.dart';

import 'clubDetailHome.dart';
import 'clubDetailBoard.dart';
import 'clubDetailCalendar.dart';
import 'clubDetailChat.dart';

import 'clubDetailTabBar.dart';

class ClubDetailView extends StatefulWidget {
  @override
  State<ClubDetailView> createState() => _ClubDetailView();
}
class _ClubDetailView extends State<ClubDetailView> with SingleTickerProviderStateMixin {
  late TabController clubDetailTabController;

  @override
  void initState() {
    super.initState();
    clubDetailTabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClubDetailTabBar(controller: clubDetailTabController, title: '모임명'),
      body: TabBarView(
        controller: clubDetailTabController,
        children: _clubDetailTabList
      )
    );
  }

  List<Widget> _clubDetailTabList = <Widget>[
    ClubDetailHome(),
    ClubDetailBoard(),
    ClubDetailCalendar(),
    ClubDetailChat(),
  ];
}