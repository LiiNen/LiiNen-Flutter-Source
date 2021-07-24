import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_flutter_source/clubObject.dart';

import 'package:my_flutter_source/containerCollection.dart';

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
      endDrawer: _loadComplete ? (_hasClub! ? AlarmDrawer() : null) : null,
      appBar: AppBar(
        centerTitle: true,
        title: Text('내 모임', textAlign: TextAlign.center),
      ),
      body: Container(
        child: (
          _loadComplete ? (_hasClub! ? ClubExist() : ClubNotExist()) : Center(child: CircularProgressIndicator())
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
        MyQuestListContainer(),
        MyFeedListContainer(),
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
        TitleContainer('내 모임들'),
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

class MyQuestListContainer extends StatefulWidget {
  @override
  State<MyQuestListContainer> createState() => _MyQuestListContainer();
}
class _MyQuestListContainer extends State<MyQuestListContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        TitleContainer('내 퀘스트 목록'),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Column(
              children: [
                Text('퀘1'),
                Text('퀘2'),
                Text('퀘3'),
                Text('퀘4'),
                Text('퀘5'),
                Text('퀘6'),
              ],
            )
          )
        )
      ]
    );
  }
}

class MyFeedListContainer extends StatefulWidget {
  @override
  State<MyFeedListContainer> createState() => _MyFeedListContainer();
}
class _MyFeedListContainer extends State<MyFeedListContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleContainer('피드'),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Column(
              children: [
                Text('피드1'),
                Text('피드2'),
                Text('피드3'),
                Text('피드4'),
                Text('피드5'),
                Text('피드6'),
                Text('피드7'),
                Text('피드8'),
                FeedObjectItem(),
                FeedObjectItem(),
                FeedObjectItem(),
                FeedObjectItem(),
                FeedObjectItem(),
                FeedObjectItem(),
              ]
            )
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