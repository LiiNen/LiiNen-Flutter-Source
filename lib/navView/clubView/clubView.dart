import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_flutter_source/clubObject.dart';

class ClubView extends StatefulWidget {
  @override
  State<ClubView> createState() => _ClubView();
}

class _ClubView extends State<ClubView> {
  bool? _hasClub;
  bool _loadComplete = false;
  @override
  void initState() {
    super.initState();
    _checkClub();
  }
  void _checkClub() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _hasClub = pref.getBool('hasClub') ?? false;
      _loadComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('내 모임')),
      ),
      body: Container(
        child: (
          _loadComplete ? (_hasClub! ? ClubExist() : ClubNotExist()) : Center(child: CircularProgressIndicator())
        )
      )
    );
  }
}

class ClubExist extends StatefulWidget {
  @override
  State<ClubExist> createState() => _ClubExist();
}
class _ClubExist extends State<ClubExist> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Text('모임이 존재합니다'),
            TextButton(
              child: Text('모임 삭제하기'),
              onPressed: _removeClub,
            )
        ]),
        MyClubListContainer(),
      ],
    );
  }
  void _removeClub() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('hasClub', false);
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
        Container(
          padding: EdgeInsets.only(left: 15),
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: Text('내 모임들', textAlign: TextAlign.left,)
        ),
        Container(
          height: 100,
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