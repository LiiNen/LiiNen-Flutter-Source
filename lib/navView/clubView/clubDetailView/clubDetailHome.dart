import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';

import 'clubDialog.dart';

class ClubMember {
  int userId;
  String? imgSrc;
  String userName;
  String userIntro;
  ClubMember({this.userId=0, this.imgSrc, required this.userName, required this.userIntro});
}
class ClubMemberList {
  int currentNum;
  int maxNum;
  List<ClubMember> member; // member 리스트의 첫번째가 모임 개설자로 되도록 사
  ClubMemberList({required this.currentNum, required this.maxNum, required this.member});
}

class ClubDetailHome extends StatefulWidget {
  @override
  State<ClubDetailHome> createState() => _ClubDetailHome();
}
class _ClubDetailHome extends State<ClubDetailHome> {
  String? _clubCategory;
  String? _clubTitle;
  String? _clubIntro;
  ClubMemberList? _clubMemberList;

  @override
  void initState() {
    super.initState();
    _getClubInfo();
  }
  void _getClubInfo() {
    // todo: get data from server
    _clubCategory = 'IT(개발/디자인)';
    _clubTitle = '코딩할 사람 모여라';
    _clubIntro = '코딩할 사람을 구해요. 우리 다같이 킹짱 개발자가 되기 위해 노력해보아요. 같이 스터디도 진행하고 개발 관련 정보도 공유해요';
    List<ClubMember> temp = [
      ClubMember(userName: '김정훈', userIntro: '안녕하세요 김정훈입니다.'),
      ClubMember(userName: '김한슬', userIntro: '안녕하세요 김한슬입니다.'),
      ClubMember(userName: '박상욱', userIntro: '안녕하세요 박상욱입니다.')
    ];
    _clubMemberList = ClubMemberList(currentNum: 3, maxNum: 5, member: temp);
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _clubCard(child: _clubTitleCard()),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 12,
        ),
        _clubCard(child: clubMemberCard(clubMemberList: _clubMemberList!, context: context)),
      ]
    );
  }

  _clubCard({required Widget child, Color color=Colors.white}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
      decoration: BoxDecoration(
        color: color,
      ),
      child: child
    );
  }
  _clubTitleCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_clubCategory!, style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0)),
        SizedBox(height: 14),
        Text(_clubTitle!, style: textStyle(weight: 700, size: 16.0)),
        SizedBox(height: 12),
        Text(_clubIntro!, style: textStyle(weight: 400, size: 12.0)),
      ] + [
        SizedBox(height: 36),
        _clubInOutButton(false),
      ]
    );
  }

  _clubInOutButton(bool isMember) {
    Color boxColor = (!isMember && (_clubMemberList!.currentNum < _clubMemberList!.maxNum) ? Color(0xff0958c5) : Color(0xffd1d5d9));
    String boxContent;
    if(!isMember) {
      if(_clubMemberList!.currentNum < _clubMemberList!.maxNum) boxContent = '가입하기';
      else boxContent = '모집마감';
    } else boxContent = '모임탈퇴';

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(boxContent == '가입하기') {showClubDialog(context: context, title: '모임에 가입하시겠습니까?', positiveAction: testFunc, negativeAction: test2Func);}
        else if(boxContent == '모임탈퇴') {showClubDialog(context: context, title: '모임을 나가시겠습니까?', positiveAction: testFunc, negativeAction: test2Func);}
        else if(boxContent == '모집마감') {
          // do nothing
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: boxColor,
        ),
        child: Center(child: Text(boxContent, style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
      )
    );
  }


  testFunc() {
    print('test');
  }
  test2Func() {
    print('test2');
  }
}

clubMemberCard({required ClubMemberList clubMemberList, isAdmin=false, required BuildContext context}) {
  var _temp = clubMemberList.member;
  List<Widget> memberRowList = List.generate(_temp.length, (index) {
    return clubMemberRow(member: _temp[index], isHead: (index==0), isAdmin: isAdmin, context: context);
  });
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('모임 멤버 (${clubMemberList.currentNum}명/${clubMemberList.maxNum}명)', style: textStyle(weight: 700, size: 14.0)),
      SizedBox(height: 14),
    ] + memberRowList
  );
}
clubMemberRow({required ClubMember member, bool isHead=false, required bool isAdmin, required BuildContext context}) {
  List<Widget> _rightElement = [];
  if(isHead) {
    _rightElement = [Expanded(
      child: Text('개설자', style: textStyle(color: Color(0xff0958c5), weight: 700, size: 12.0), textAlign: TextAlign.right,)
    )];
  } else if(isAdmin) {
    _rightElement = [Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {showClubDialog(context: context, title: '${member.userName}님을 강퇴하시겠습니까?', positiveAction: testFunction, negativeAction: testFunction);},
          child: Container(
            width: 42, height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(0xfff3f3f3)
            ),
            child: Center(
              child: Text('강퇴', style: textStyle(color: Color(0xff666666), weight: 400, size: 10.0))
            )
          )
        )
      )
    )];
  }

  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            )
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.userName, style: textStyle(weight: 600, size: 12.0)),
              SizedBox(height: 2),
              Text(member.userIntro, style: textStyle(weight: 400, size: 12.0))
            ]
          ),
        ] + _rightElement
      )
    )
  );
}

testFunction() {
  print('test');
}