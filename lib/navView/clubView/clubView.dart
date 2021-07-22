import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Container(
        child: Center(
          child: Column(
            children: [
              Text('모임이 존재합니다'),
              TextButton(
                child: Text('모임 삭제하기'),
                onPressed: _removeClub,
              )
            ],
          )
        )
    );
  }

  void _removeClub() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('hasClub', false);
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

Future<TestPost> testPost() async {
  await dotenv.load();
  String key = dotenv.env['RIOT_API_KEY']!;
  final response = await http.get(Uri.parse('https://kr.api.riotgames.com/lol/platform/v3/champion-rotations?api_key=$key'));
  if (response.statusCode == 200) {
    return TestPost.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class TestPost {
  final List<int> freeOld;
  final List<int> freeNew;
  final int level;
  TestPost({required this.freeOld, required this.freeNew, required this.level});

  factory TestPost.fromJson(Map<String, dynamic> json) {
    return TestPost(freeOld: json['freeChampionIds'].cast<int>(), freeNew: json['freeChampionIdsForNewPlayers'].cast<int>(), level: json['maxNewPlayerLevel']);
  }
}