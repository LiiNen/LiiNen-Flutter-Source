import 'package:flutter/material.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

class DeleteAccountView extends StatefulWidget {
  @override
  State<DeleteAccountView> createState() => _DeleteAccountView();
}
class _DeleteAccountView extends State<DeleteAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '계정탈퇴', back: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(32),
                Text('정말로 탈퇴하시겠습니까?', style: textStyle(weight: 700, size: 20.0)),
                sizedBox(16),
                Text('회원탈퇴시 정보가 영구히 삭제됩니다.', style: textStyle(weight: 400, size: 16.0)),
              ]
            ),
            Column(
              children: [
                checkBoxWithText(context: context, title: '위 사항에 동의하며, 계정을 삭제합니다.', condition: _isChecked, tapAction: agreeTap),
                sizedBox(16),
                confirmButton(title: '탈퇴하기', confirmAction: deleteAccount, condition: false),
                sizedBox(56),
              ],
            )
          ]
        )
      )
    );
  }

  bool _isChecked = false;
  void agreeTap() {
    setState(() {
      _isChecked = !_isChecked;
      print('tap');
    });
  }

  void deleteAccount() {
    print('탈퇴하기');
  }
}