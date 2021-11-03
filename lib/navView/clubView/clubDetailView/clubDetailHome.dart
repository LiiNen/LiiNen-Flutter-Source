import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/navView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

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
  final dynamic result;
  ClubDetailHome(this.result);

  @override
  State<ClubDetailHome> createState() => _ClubDetailHome(result);
}
class _ClubDetailHome extends State<ClubDetailHome> {
  dynamic result;
  _ClubDetailHome(this.result);

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
    _clubCategory = getCategoryName(result['category']['_id']);
    _clubTitle = result['name'];
    _clubIntro = result['introduction'];
    List<ClubMember> temp = [
      ClubMember(userName: result['persons']['president']['name'], userIntro: result['persons']['president']['introduce'])
    ];
    result['persons']['members'].toList().map((e) {
      temp.add(ClubMember(userName: e['name'], userIntro: e['introduce']));
    });
    _clubMemberList = ClubMemberList(currentNum: result['personsCount'], maxNum: result['maxPerson'], member: temp);
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
    bool _isMember = false;
    if(result['persons']['president']['_id'] == userInfo['_id']) {
      _isMember = true;
      print('president');
    }
    else {
      result['persons']['members'].toList().map((e) {
        if (e['_id'] == userInfo['_id']) _isMember = true;
      });
    }
    print(_isMember ? 'member' : 'not member');

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
        _clubInOutButton(_isMember),
      ]
    );
  }

  _clubInOutButton(bool isMember) {
    Color boxColor = (!isMember && (_clubMemberList!.currentNum < _clubMemberList!.maxNum) ? Color(0xff0958c5) : Color(0xffd1d5d9));
    String boxContent;
    if(result['persons']['president']['_id'] == userInfo['_id']) boxContent = '모임 삭제';
    else if(!isMember) {
      if(_clubMemberList!.currentNum < _clubMemberList!.maxNum) boxContent = '가입하기';
      else boxContent = '모집마감';
    } else boxContent = '모임탈퇴';

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(boxContent == '가입하기') {showClubDialog(context: context, title: '모임에 가입하시겠습니까?', positiveAction: joinClub, negativeAction: (){});}
        else if(boxContent == '모임탈퇴') {showClubDialog(context: context, title: '모임을 나가시겠습니까?', positiveAction: quitClub, negativeAction: (){});}
        else if(boxContent == '모집마감') {
          // do nothing
        }
        else if(boxContent == '모임 삭제') {
          showClubDialog(context: context, title: '모임을 삭제하시겠습니까?', positiveAction: deleteClub, negativeAction: (){});
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

  quitClub() async {
    var response = await quitMeeting(meetingId: result['_id']);
    if(response == true) {
      showToast('모임에서 탈퇴하셨습니다.');
      await reloadUserData();
      navigatorPush(context: context, widget: NavView(selectedIndex: 2,), replacement: true, all: true);
    }
  }
  deleteClub() async {
    var response = await quitMeeting(meetingId: result['_id'], isPresident: true);
    if(response == true) {
      showToast('모임이 성공적으로 삭제되었습니다.');
      await reloadUserData();
      navigatorPush(context: context, widget: NavView(selectedIndex: 2), replacement: true, all: true);
    }
  }
  joinClub() async {
    var response = await actionMeeting(meetingId: result['_id'], userId: userInfo['_id'], type: 'join');
    print(response);
    if(response) {
      showClubDialog(context: context, title: '모임 가입 신청 완료', positiveAction: (){}, negativeAction: (){}, confirmAction: (){});
    }
    else {
      showToast('네트워크 상태를 확인해주세요');
    }
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
          onTap: () {showClubDialog(context: context, title: '${member.userName}님을 강퇴하시겠습니까?', positiveAction: (){}, negativeAction: (){});},
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

  kickUser() {

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
