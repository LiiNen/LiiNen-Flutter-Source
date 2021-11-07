import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailHome.dart';

class ClubMemberSettingView extends StatefulWidget {
  final dynamic result;
  ClubMemberSettingView(this.result);

  @override
  State<ClubMemberSettingView> createState() => _ClubMemberSettingView(result);
}
class _ClubMemberSettingView extends State<ClubMemberSettingView> {
  dynamic result;
  _ClubMemberSettingView(this.result);

  ClubMemberList? _clubMemberList;

  @override
  void initState() {
    super.initState();
    getClubMemberList();
  }

  getClubMemberList() {
    List<ClubMember> temp = [
      ClubMember(userId: result['persons']['president']['_id'], imgSrc: result['persons']['president']['imageUrl'], userName: result['persons']['president']['name'], userIntro: result['persons']['president']['introduce'])
    ];
    result['persons']['members'].toList().map((e) {
      temp.add(ClubMember(userId: e['_id'], imgSrc: e['imageUrl'], userName: e['name'], userIntro: e['introduce']));
    });
    setState(() {
      _clubMemberList = ClubMemberList(currentNum: result['personsCount'], maxNum: result['maxPerson'], member: temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '멤버 관리', back: true),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            SizedBox(height: 28),
            clubMemberCard(meetingId: result['_id'], clubMemberList: _clubMemberList!, isAdmin: true, context: context),
          ],
        )
      )
    );
  }
}