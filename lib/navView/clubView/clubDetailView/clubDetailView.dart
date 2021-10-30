import 'package:flutter/material.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import 'clubDetailHome.dart';
import 'clubDetailBoard.dart';
import 'clubDetailCalendar.dart';
import 'clubDetailChat.dart';

import 'clubDetailTabBar.dart';

class ClubDetailView extends StatefulWidget {
  final String _id;
  ClubDetailView(this._id);

  @override
  State<ClubDetailView> createState() => _ClubDetailView(_id);
}
class _ClubDetailView extends State<ClubDetailView> with SingleTickerProviderStateMixin {
  String _id;
  _ClubDetailView(this._id);
  dynamic result;

  late TabController clubDetailTabController;

  @override
  void initState() {
    super.initState();
    clubDetailTabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _getMeeting();
  }

  void _getMeeting() async {
    var _temp = await getMeetingById(_id);
    setState(() {
      result = _temp;
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClubDetailTabBar(controller: clubDetailTabController, title: result != null ? result['name'] : ''),
      body: result != null ? TabBarView(
        controller: clubDetailTabController,
        children: [
          ClubDetailHome(result),
          ClubDetailBoard(),
          ClubDetailCalendar(),
          ClubDetailChat(),
        ]
      ) : Container()
    );
  }
}