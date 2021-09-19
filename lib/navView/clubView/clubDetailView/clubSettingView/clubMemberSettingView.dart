import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailHome.dart';

class ClubMemberSettingView extends StatefulWidget {
  @override
  State<ClubMemberSettingView> createState() => _ClubMemberSettingView();
}
class _ClubMemberSettingView extends State<ClubMemberSettingView> {
  ClubMemberList? _clubMemberList;

  @override
  void initState() {
    super.initState();
    List<ClubMember> temp = [
      ClubMember(userName: '김정훈', userIntro: '안녕하세요 김정훈입니다.'),
      ClubMember(userName: '김한슬', userIntro: '안녕하세요 김한슬입니다.'),
      ClubMember(userName: '박상욱', userIntro: '안녕하세요 박상욱입니다.')
    ];
    _clubMemberList = ClubMemberList(currentNum: 3, maxNum: 5, member: temp);
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
            clubMemberCard(clubMemberList: _clubMemberList!, isAdmin: true, context: context),
          ],
        )
      )
    );
  }
}