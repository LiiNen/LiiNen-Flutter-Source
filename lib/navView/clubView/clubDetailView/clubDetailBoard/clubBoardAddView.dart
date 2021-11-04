import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';

import '../../../../containerCollection.dart';
import '../../../../main.dart';

class ClubBoardAddView extends StatefulWidget {
  @override
  State<ClubBoardAddView> createState() => _ClubBoardAddView();
}
class _ClubBoardAddView extends State<ClubBoardAddView> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
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
                textField(controller: titleController, focusNode: titleFocusNode, hint: '제목을 입력해주세요'),
                SizedBox(height: 20),
                Text('내용 작성', style: textStyle(weight: 700, size: 14.0)),
                SizedBox(height: 8),
                textField(controller: contentController, focusNode: contentFocusNode, hint: '내용을 작성해주세요', allowEnter: true),
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

  textField({required controller, required focusNode, required hint, allowEnter=false}) {
    return TextField(
      controller: controller,
      autofocus: false,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
        enabledBorder: enabledBorderDefault(),
        focusedBorder: focusedBorderDefault(),
        hintText: hint,
        hintStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0),
      ),
      style: textStyle(weight: 600, size: 12.0),
      keyboardType: allowEnter ? TextInputType.multiline : TextInputType.text,
      textInputAction: allowEnter ? TextInputAction.newline : TextInputAction.done,
      maxLines: allowEnter ? null : 1,
      onChanged: (value) {setState(() {
        if(titleController.text != '' && contentController.text != '') {
          isComplete = true;
        }
        else isComplete = false;
      });},
      onSubmitted: (value) {
        if(allowEnter == false) contentFocusNode.requestFocus();
      },
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
