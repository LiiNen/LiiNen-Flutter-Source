import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/restApi/questApi.dart';

import '../../../../functionCollection.dart';

class ClubQuestDetailView extends StatefulWidget {
  final String questId;
  ClubQuestDetailView(this.questId);

  @override
  State<ClubQuestDetailView> createState() => _ClubQuestDetailView(questId);
}
class _ClubQuestDetailView extends State<ClubQuestDetailView> {
  String questId;
  _ClubQuestDetailView(this.questId);

  dynamic questInfo;

  @override
  void initState() {
    super.initState();
    _getBoard();
  }

  void _getBoard() async {
    var temp = await getQuestById(questId: questId);
    if (temp == null)
      showToast('네트워크 상태를 확인해주세요');
    else {
      setState(() {
        questInfo = temp;
        print(questInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '퀘스트', back: true),
      body: SingleChildScrollView(
        child: questInfo != null ? Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              contentField(),
              SizedBox(height: 8),
            ]
          )
        ) : Container()
      )
    );
  }

  Widget contentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questInfo['title'], style: textStyle(weight: 700, size: 14.0)),
        SizedBox(height: 4),
        Text(questInfo['contents'], style: textStyle(weight: 400, size: 10.0)),
        SizedBox(height: 12),
      ]
    );
  }
}
