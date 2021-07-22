import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClubView extends StatefulWidget {
  @override
  State<ClubView> createState() => _ClubView();
}

class _ClubView extends State<ClubView> {
  late Future<TestPost> post;

  @override
  void initState() {
    super.initState();
    post = testPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('제목'),
      ),
      body: Container(
        child: FutureBuilder<TestPost>(
          future: post,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              print(snapshot.data!.freeOld.toString());
              print(snapshot.data!.freeNew.toString());
              print(snapshot.data!.level.toString());
              return Container(child: Text(snapshot.data!.level.toString()));
            }
            else if(snapshot.hasError) {
              print(snapshot.error);
            }
            return CircularProgressIndicator();
          },
        )
      )
    );
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