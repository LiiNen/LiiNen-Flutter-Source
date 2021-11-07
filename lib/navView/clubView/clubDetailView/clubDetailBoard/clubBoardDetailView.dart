import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/restApi/boardApi.dart';

import '../../../../containerCollection.dart';
import '../../../../main.dart';

class ClubBoardDetailView extends StatefulWidget {
  final String boardId;
  ClubBoardDetailView(this.boardId);

  @override
  State<ClubBoardDetailView> createState() => _ClubBoardDetailView(boardId);
}
class _ClubBoardDetailView extends State<ClubBoardDetailView> {
  String boardId;
  _ClubBoardDetailView(this.boardId);

  dynamic boardInfo;

  @override
  void initState() {
    super.initState();
    _getBoard();
  }

  void _getBoard() async {
    var temp = await getBoard(postId: boardId);
    if(temp == null) showToast('네트워크 상태를 확인해주세요');
    else {
      setState(() {
        boardInfo = temp[0];
        print(boardInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '게시글', back: true),
      body: SingleChildScrollView(
        child: boardInfo != null ? Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoField(),
              SizedBox(height: 16),
              contentField(),
              boardInfo['imageUrls'].length != 0 ? imageField() : Container(),
              Row(
                children: [
                  boardButton('like'),
                  SizedBox(width: 8),
                  boardButton('comment'),
                ]
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset('asset/image/heartIco.svg', width: 20, height: 20),
                  SizedBox(width: 4),
                  Text('좋아요 ${boardInfo['likesCount']}개', style: textStyle(color: Color(0xff8a8a8a), weight: 500, size: 12.0))
                ]
              )
            ]
          )
        ) : Container()
      )
    );
  }

  Widget infoField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // todo: image url when api modified
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(18),
            //   child: item.thumbnailUrl == null
            //     ? Image.asset('asset/loginView/profile.png', width: 36, height: 36,)
            //     : Image.network(item.thumbnailUrl!, width: 36, height: 36, fit: BoxFit.cover,),
            // ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('유저명', style: textStyle(weight: 700, size: 14.0)),
                Text(timeParser(boardInfo['createdAt']), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0))
              ]
            )
          ]
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {

          },
          child: SvgPicture.asset('asset/image/moreBtn.svg', width: 24, height: 24,)
        )
      ]
    );
  }

  Widget contentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(boardInfo['title'], style: textStyle(weight: 700, size: 14.0)),
        SizedBox(height: 4),
        Text(boardInfo['contents'], style: textStyle(weight: 400, size: 10.0)),
        SizedBox(height: 12),
      ]
    );
  }

  Widget imageField() {
    return Column(
      children: [
        Text('image field'),
        SizedBox(height: 12),
      ]
    );
  }

  Widget boardButton(String type) {
    String? _title;
    SvgPicture? _icon;
    dynamic _action;
    if(type == 'like') {
      _title = '좋아요';
      _icon = SvgPicture.asset('asset/image/heartIco.svg', width: 16, height: 16);
      _action = _likeAction;
    }
    else if (type == 'comment') {
      _title = '댓글달기';
      _icon = SvgPicture.asset('asset/image/messageIco.svg', width: 16, height: 16);
    }

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {_action();},
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(4)
            ),
            border: Border.all(
              color: const Color(0xffe6e6e6),
              width: 1
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon!,
              SizedBox(width: 4),
              Text(_title!, style: textStyle(color: Color(0xff8a8a8a), weight: 500, size: 14.0),)
            ]
          )
        )
      )
    );
  }

  _likeAction() async {
    var response = await patchBoardLike(postId: boardId, userId: userInfo['_id']);
    if(response == true) {
      _getBoard();
    }
    else if(response != true) {
      showToast('네트워크 상태를 확인해주세요');
    }
  }

  _commentAction() async {

  }
}