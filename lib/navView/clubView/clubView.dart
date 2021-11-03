import 'package:flutter/material.dart';
import 'package:my_flutter_source/navView/profileView/profileView.dart';
import 'package:my_flutter_source/navView/searchView/searchResult/resultItemContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_flutter_source/clubObject.dart';

import 'package:my_flutter_source/containerCollection.dart';

class ClubView extends StatefulWidget {
  @override
  State<ClubView> createState() => _ClubView();
}

class _ClubView extends State<ClubView> {
  bool _hasClub = (userProfile['meetings']['joining'] != []);
  bool _loadComplete = false;

  @override
  void initState() {
    super.initState();
    _checkClub();
  }
  void _checkClub() async {
    setState(() {
      _hasClub = (userProfile['meetings']['joining'] != []);
      _loadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _loadComplete ? (_hasClub ? AlarmDrawer() : null) : null,
      appBar: MainViewAppBar(title: '내 모임'),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: (
          _loadComplete ? ClubExist() : Center(child: CircularProgressIndicator())
        )
      )
    );
  }
}

class AlarmDrawer extends StatefulWidget {
  @override
  State<AlarmDrawer> createState() => _AlarmDrawer();
}
class _AlarmDrawer extends State<AlarmDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          DrawerHeader(
            child: Text('알림', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('alarm 1'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('alarm 2'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('alarm 1'),
            onTap: () => {},
          ),
        ],
      )
    );
  }
}

class ClubExist extends StatefulWidget {
  @override
  State<ClubExist> createState() => _ClubExist();
}
class _ClubExist extends State<ClubExist> {
  var _results = userProfile['meetings']['joining'];

  @override
  Widget build(BuildContext context) {
    return ResultItemContainer(results: _results, isSearch: false);
  }
}

class MyClubListContainer extends StatefulWidget {
  @override
  State<MyClubListContainer> createState() => _MyClubListContainer();
}
class _MyClubListContainer extends State<MyClubListContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleContainer(title: '내 모임들'),
        Container(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: clubObjectList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClubObjectItem(clubObjectList[index]);
            },
          )
        )
      ]
    );
  }
}

class ClubNotExist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('모임이 존재하지 않아요'),
            TextButton(
              child: Text('모임 추가하기'),
              onPressed: _addClub,
            )
          ],
        )
      )
    );
  }
  void _addClub() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('hasClub', true);
  }
}