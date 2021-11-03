import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';

import '../../../containerCollection.dart';
import '../../../main.dart';

class ClubDetailBoardView extends StatefulWidget {
  @override
  State<ClubDetailBoardView> createState() => _ClubDetailBoardView();
}
class _ClubDetailBoardView extends State<ClubDetailBoardView> {

  bool isComplete=false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
        appBar: MainViewAppBar(title: '글 작성', back: true),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 28),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제목', style: textStyle(weight: 700, size: 14.0)),
                SizedBox(height: 8),
                SizedBox(height: 20),
                Text('내용 작성', style: textStyle(weight: 700, size: 14.0)),
                SizedBox(height: 8),
                SizedBox(height: 20),
                Text('사진', style: textStyle(weight: 700, size: 14.0)),
                SizedBox(height: 8),
                SizedBox(height: 20),
                confirmButton(title: '작성 완료', confirmAction: submitAction, condition: isComplete)
              ]
            )
          )
        )
      )
    );
  }

  submitAction() async {
    if(isComplete == true) {
      //todo: post
    }
    else {
      showToast('제목과 내용 모두 작성해주세요.');
    }
  }
}
