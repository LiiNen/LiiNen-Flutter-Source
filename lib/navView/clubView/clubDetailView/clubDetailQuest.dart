import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/restApi/questApi.dart';
import 'package:my_flutter_source/restApi/restApi.dart';

import '../../../functionCollection.dart';
import '../../../main.dart';
import 'clubDetailQuest/clubQuestDetailView.dart';

class ClubDetailQuest extends StatefulWidget {
  final dynamic result;
  ClubDetailQuest(this.result);

  @override
  State<ClubDetailQuest> createState() => _ClubDetailQuest(result);
}
class _ClubDetailQuest extends State<ClubDetailQuest> {
  dynamic result;
  _ClubDetailQuest(this.result);

  bool isLoaded = false;
  List _questList = [];
  List _ongoingList = [];
  List _completeList = [];
  List _doneList = [];

  @override
  void initState() {
    super.initState();
    _getQuest();
  }

  void _getQuest() async {
    var _temp = await getMeetingQuest(meetingId: result['_id']);
    isLoaded = true;
    if(_temp == null) {
      showToast('네트워크를 확인해주세요');
    }
    else {
      setState(() {
        _questList = _temp;
        for (var quest in _questList) {
          if(quest['isActive'] == false) _doneList.add(quest);
          else {
            bool _isBreak = false;
            for (var user in quest['users']['ongoing']) {
              if (user['_id'] == userInfo['_id']) {
                _ongoingList.add(quest);
                _isBreak = true;
                break;
              }
            }
            if(_isBreak) continue;
            for (var user in quest['users']['completion']) {
              if (user['_id'] == userInfo['_id']) {
                _completeList.add(quest);
                break;
              }
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
        child: isLoaded ? (
          _questList.length != 0 ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                questListContainer(0),
                _ongoingList.length == 0 ? LineDivider(horizontalMargin: false,) : Container(),
                questListContainer(1),
                _completeList.length == 0 ? LineDivider(horizontalMargin: false,) : Container(),
                questListContainer(2),
              ]
            )
          ) : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 238 * responsiveScale),
                SvgPicture.asset('asset/image/icoFail.svg', width: 28, height: 48),
                SizedBox(height: 24),
                Text('퀘스트가 없습니다.', style: textStyle(weight: 600, size: 16.0),),
              ],
            )
          )
        ) : Center(child: CircularProgressIndicator()),
      )
    );
  }

  questListContainer(int type) {
    String title = '';
    List _tempList = [];
    if(type == 0) {
      title = '도전 중인 퀘스트 ${_ongoingList.length} 건';
      _tempList = _ongoingList;
    }
    else if(type == 1) {
      title = '완료한 퀘스트 ${_completeList.length} 건';
      _tempList = _completeList;
    }
    else if(type == 2) {
      title = '종료된 퀘스트 ${_doneList.length} 건';
      _tempList = _doneList;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 12),
        Text(title, style: textStyle(weight: 700, size: 14.0)),
        SizedBox(height: 12),
      ] + List.generate(_tempList.length, (index) {
        return questItemBox(_tempList[index]);
      }),
    );
  }

  questItemBox(_quest) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        navigatorPush(context: context, widget: ClubQuestDetailView(_quest['_id']));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: const Color(0xffd1d5d9), width: 1),
          color: Color(0xffffffff)
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_quest['title'], style: textStyle(weight: 700, size: 14.0)),
              SizedBox(height: 4),
              Text(_quest['contents'], style: textStyle(weight: 400, size: 10.0)),
              SizedBox(height: 24),
              Text('도전 중인 사람: ${_ongoingList.length}명', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0))
            ]
          )
        )
      )
    );
  }
}