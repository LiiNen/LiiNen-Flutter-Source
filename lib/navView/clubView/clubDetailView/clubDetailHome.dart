import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/navView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import 'clubDialog.dart';

class ClubMember {
  String userId;
  String imgSrc;
  String userName;
  String userIntro;
  ClubMember({this.userId='', this.imgSrc='', required this.userName, required this.userIntro});
}
class ClubMemberList {
  int currentNum;
  int maxNum;
  List<ClubMember> member;
  ClubMemberList({this.currentNum=-1, this.maxNum=-1, required this.member});
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

  bool isWaiting = false;
  String? _clubCategory;
  String? _clubTitle;
  String? _clubIntro;
  ClubMemberList? _clubMemberList;
  ClubMemberList? _waitingList;

  @override
  void initState() {
    super.initState();
    _getClubInfo();
  }

  void _getClubInfo() {
    setState(() {
      _clubCategory = getCategoryName(result['category']['_id']);
      _clubTitle = result['name'];
      _clubIntro = result['introduction'];
      List<ClubMember> temp = [
        ClubMember(userId: result['persons']['president']['_id'], imgSrc: result['persons']['president']['imageUrl'], userName: result['persons']['president']['name'], userIntro: result['persons']['president']['introduce'])
      ];
      for (var e in result['persons']['members']) temp.add(ClubMember(userId: e['_id'], imgSrc: e['imageUrl'], userName: e['name'], userIntro: e['introduce']));
      _clubMemberList = ClubMemberList(currentNum: result['personsCount'], maxNum: result['maxPerson'], member: temp);
      temp = [];
      for (var e in result['persons']['waiting']) {
        if(e['_id'] == userInfo['_id']) isWaiting = true;
        temp.add(ClubMember(userId: e['_id'], imgSrc: e['imageUrl'], userName: e['name'], userIntro: e['introduce']));
      }
      _waitingList = ClubMemberList(member: temp, maxNum: temp.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _clubCard(child: _clubTitleCard()),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 12,
        ),
        _clubCard(child: clubMemberCard(meetingId: result['_id'], clubMemberList: _clubMemberList!, context: context)),
        SizedBox(height: 12),
        _waitingList!.member.length == 0 ? Container() : _clubCard(child: clubMemberCard(meetingId: result['_id'], isAdmin: userInfo['_id'] == result['persons']['president']['_id'], clubMemberList: _waitingList!, context: context)),
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
    }
    else {
      result['persons']['members'].toList().map((e) {
        if (e['_id'] == userInfo['_id']) _isMember = true;
      });
    }

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
    Color boxColor = (!isWaiting && !isMember && (_clubMemberList!.currentNum < _clubMemberList!.maxNum) ? Color(0xff0958c5) : Color(0xffd1d5d9));
    String boxContent;
    if(isWaiting) {
      boxContent = '?????? ?????????';
    }
    else if(result['persons']['president']['_id'] == userInfo['_id']) boxContent = '?????? ??????';
    else if(!isMember) {
      if(_clubMemberList!.currentNum < _clubMemberList!.maxNum) boxContent = '????????????';
      else boxContent = '????????????';
    } else boxContent = '????????????';

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(boxContent == '?????? ?????????') {
          // do nothing
        }
        else if(boxContent == '????????????') {showClubDialog(context: context, title: '????????? ?????????????????????????', positiveAction: joinClub, negativeAction: (){});}
        else if(boxContent == '????????????') {showClubDialog(context: context, title: '????????? ??????????????????????', positiveAction: quitClub, negativeAction: (){});}
        else if(boxContent == '????????????') {
          // do nothing
        }
        else if(boxContent == '?????? ??????') {
          showClubDialog(context: context, title: '????????? ?????????????????????????', positiveAction: deleteClub, negativeAction: (){});
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
      showToast('???????????? ?????????????????????.');
      await reloadUserData();
      navigatorPush(context: context, widget: NavView(selectedIndex: 2,), replacement: true, all: true);
    }
  }
  deleteClub() async {
    var response = await quitMeeting(meetingId: result['_id'], isPresident: true);
    if(response == true) {
      showToast('????????? ??????????????? ?????????????????????.');
      await reloadUserData();
      navigatorPush(context: context, widget: NavView(selectedIndex: 2), replacement: true, all: true);
    }
  }
  joinClub() async {
    var response = await actionMeeting(meetingId: result['_id'], userId: userInfo['_id'], type: 'join');
    print(response);
    if(response) {
      showClubDialog(context: context, title: '?????? ?????? ?????? ??????', positiveAction: (){}, negativeAction: (){}, confirmAction: (){});
    }
    else {
      showToast('???????????? ????????? ??????????????????');
    }
  }
}

clubMemberCard({required String meetingId, required ClubMemberList clubMemberList, isAdmin=false, required BuildContext context}) {
  var _temp = clubMemberList.member;
  List<Widget> memberRowList = [];
  if(clubMemberList.currentNum == -1) {
    memberRowList = List.generate(_temp.length, (index) {
      return clubMemberRow(meetingId: meetingId, member: _temp[index], isAdmin: isAdmin, isWaiting: true, context: context);
    });
  }
  else {
    memberRowList = List.generate(_temp.length, (index) {
      return clubMemberRow(meetingId: meetingId, member: _temp[index], isHead: (index==0), isAdmin: isAdmin, context: context);
    });
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      clubMemberList.currentNum != -1
        ? Text('?????? ?????? (${clubMemberList.currentNum}???/${clubMemberList.maxNum}???)', style: textStyle(weight: 700, size: 14.0))
        : Text('?????? ????????? (${clubMemberList.maxNum}???)', style: textStyle(weight: 700, size: 14.0)),
      SizedBox(height: 14),
    ] + memberRowList
  );
}

clubMemberRow({required String meetingId, required ClubMember member, bool isHead=false, required bool isAdmin, bool isWaiting=false, required BuildContext context}) {

  acceptUser() async {
    var response = await actionMeeting(meetingId: meetingId, userId: member.userId, type: 'accept');
    print(response);
  }
  rejectUser() async {
    var response = await actionMeeting(meetingId: meetingId, userId: member.userId, type: 'reject');
    print(response);
  }

  kickUser() {

  }

  List<Widget> _rightElement = [];
  if(isHead) {
    _rightElement = [Expanded(
      child: Text('?????????', style: textStyle(color: Color(0xff0958c5), weight: 700, size: 12.0), textAlign: TextAlign.right,)
    )];
  } else if(isAdmin) {
    _rightElement = [Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if(isWaiting) {
              showClubDialog(context: context, title: '${member.userName}?????? ?????????????????????????', positiveAction: acceptUser, negativeAction: rejectUser, positiveWord: '??????', negativeWord: '??????');
            }
            else {
              showClubDialog(context: context, title: '${member.userName}?????? ?????????????????????????', positiveAction: () {}, negativeAction: () {});
            }
          },
          child: Container(
            width: 42, height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(0xfff3f3f3)
            ),
            child: Center(
              child: Text(isWaiting ? '??????' : '??????', style: textStyle(color: Color(0xff666666), weight: 400, size: 10.0))
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
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20 * responsiveScale),
            child: member.imgSrc == ''
              ? Image.asset('asset/loginView/profile.png', width: 40 * responsiveScale, height: 40 * responsiveScale,)
              : Image.network(httpsToHttp(member.imgSrc), width: 40 * responsiveScale, height: 40 * responsiveScale, fit: BoxFit.cover,),
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
