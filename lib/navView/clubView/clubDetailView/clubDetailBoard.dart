import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailBoard/clubBoardDetailView.dart';
import 'package:my_flutter_source/restApi/boardApi.dart';

class ClubDetailBoard extends StatefulWidget {
  final dynamic result;
  ClubDetailBoard(this.result);
  @override
  State<ClubDetailBoard> createState() => _ClubDetailBoard(result);
}
class _ClubDetailBoard extends State<ClubDetailBoard> {
  dynamic result;
  _ClubDetailBoard(this.result);
  List clubBoardList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getBoard();
  }

  _getBoard() async {
    var response = await getClubBoard(meetingId: result['_id']);
    if(response != null) {
      setState(() {
        clubBoardList = response;
        isLoaded = true;
      });
    }
    else {
      showToast('네트워크를 확인해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff8f9fa),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 21, vertical: 12),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: isLoaded ?
          (clubBoardList.length != 0 ?
            SingleChildScrollView(
              child: Column(
                children: List.generate(clubBoardList.length, (index) {
                  return boardItemBox(clubBoardList[index]);
                })
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
                  Text('게시물이 없습니다.', style: textStyle(weight: 600, size: 16.0),),
                ],
              )
            )
          ) : Center(child: CircularProgressIndicator()),
      )
    );
  }

  boardItemBox(clubBoard) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        navigatorPush(context: context, widget: ClubBoardDetailView(clubBoard['_id']));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [BoxShadow(
            color: Color(0x338d979e),
            offset: Offset(0,0),
            blurRadius: 30,
            spreadRadius: 0
          )] ,
          color: Color(0xffffffff)
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clubBoard['title'], style: textStyle(weight: 700, size: 14.0)),
              SizedBox(height: 4),
              Text(clubBoard['contents'], style: textStyle(weight: 400, size: 10.0)),
              SizedBox(height: 24),
              Text(clubBoard['author'], style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('asset/image/heartIco.svg', width: 16, height: 16),
                      SizedBox(width: 4),
                      Text(clubBoard['likesCount'].toString(), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
                      SizedBox(width: 12),
                      SvgPicture.asset('asset/image/messageIco.svg', width: 16, height: 16),
                      SizedBox(width: 4),
                      Text(clubBoard['commentsCount'].toString(), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
                    ]
                  ),
                  Text(timeParser(clubBoard['createdAt']), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0))
                ]
              )
            ]
          )
        )
      )
    );
  }
}

