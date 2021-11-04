import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailBoard/clubBoardAddView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import 'clubDetailAppBar.dart';
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
  bool _isMember=false;

  late TabController clubDetailTabController;

  @override
  void initState() {
    super.initState();
    clubDetailTabController = TabController(length: 4, vsync: this, initialIndex: 0);
    clubDetailTabController.addListener(tabChangeListener);
    _getMeeting();
  }

  @override
  void dispose() {
    clubDetailTabController.dispose();
    super.dispose();
  }

  tabChangeListener() {
    if(clubDetailTabController.indexIsChanging) setState(() {});
  }

  void _getMeeting() async {
    var _temp = await getMeetingById(_id);
    setState(() {
      result = _temp;
      if(result['persons']['president']['_id'] == userInfo['_id']) {
        _isMember = true;
      }
      else {
        result['persons']['members'].toList().map((e) {
          if (e['_id'] == userInfo['_id']) _isMember = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClubDetailAppBar(
        title: result != null ? result['name'] : '',
        isPresident: result != null ? userInfo['_id'] == result['persons']['president']['_id'] : false,
        result: result
      ),
      body: result != null ? SingleChildScrollView(
        child: Column(
          children: [
            ClubDetailTabBar(controller: clubDetailTabController, isMember: _isMember),
            clubDetailTabBarView(controller: clubDetailTabController, result: result)
          ]
        )
      ) : Container(),
      floatingActionButton: clubDetailTabController.index == 1 ? Container(
        width: 48, height: 48,
        child: FloatingActionButton(
          onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ClubBoardAddView()))},
          backgroundColor: Color(0xff0958c5),
          child: SvgPicture.asset('asset/image/icoPlus.svg', width: 20, height: 20),
        )
      ) : null,
    );
  }
}