import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

class ClubDetailSetupView extends StatefulWidget {
  @override
  State<ClubDetailSetupView> createState() => _ClubDetailSetupView();
}
class _ClubDetailSetupView extends State<ClubDetailSetupView> {
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubIntroController = TextEditingController();
  TextEditingController clubLimitController = TextEditingController();

  FocusNode clubNameFocusNode = FocusNode();
  FocusNode clubIntroFocusNode = FocusNode();
  FocusNode clubLimitFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainViewAppBar(title: '모임개설', back: true,),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(8),
                detailTitle('모임 사진'),
                // TODO : image get(profileSetupView)
                clubImageSetupContainer(),
                detailTitle('모임 이름'),
                _setupTextField(
                  placeholder: '모임이름을 입력해주세요', controller: clubNameController, focusNode: clubNameFocusNode,
                  nextNode: clubIntroFocusNode,
                ),
                detailTitle('모임 소개'),
                // TODO : max line setup
                _setupTextField(placeholder: '모임소개 및 목표를 설명해주세요', controller: clubIntroController, focusNode: clubIntroFocusNode,
                  nextNode: clubLimitFocusNode
                ),
                detailTitle('인원 수 (1~15명)'),
                _setupTextField(placeholder: '0', controller: clubLimitController, focusNode: clubLimitFocusNode,
                  isNext: false,
                )
              ]
            )
          )
        )
      ),
    );
  }

  Container detailTitle(String _title) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 8),
      child: Text(_title, style: textStyle(weight: 700, size: 14.0)),
    );
  }

  GestureDetector clubImageSetupContainer() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 333 * responsiveScale,
        height: 160 * responsiveScale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(color: Color(0xffe4e4e4), width: 1),
        ),
      )
    );
  }

  _setupTextField({required String placeholder, required TextEditingController controller, required FocusNode focusNode, bool isNext=true, FocusNode? nextNode}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
        enabledBorder: enabledBorderDefault(),
        focusedBorder: focusedBorderDefault(),
        hintText: placeholder,
        hintStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0)
      ),
      style: textStyle(weight: 600, size: 12.0),
      textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
      //TODO : remove warning
      onSubmitted: (value) {
        if(nextNode != null) nextNode!.requestFocus();
        else sendAction();
      },
    );
  }
  void sendAction() {

  }
}