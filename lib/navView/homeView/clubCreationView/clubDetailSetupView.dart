import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
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

  PickedFile? _clubImage;
  bool _fieldComplete = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: MainViewAppBar(title: '모임개설', back: true,),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(8),
                detailTitle('모임 사진'),
                clubImageSetupContainer(),
                detailTitle('모임 이름'),
                _setupTextField(
                  placeholder: '모임이름을 입력해주세요', controller: clubNameController, focusNode: clubNameFocusNode,
                  nextNode: clubIntroFocusNode,
                ),
                detailTitle('모임 소개'),
                // TODO : max line setup
                _setupTextField(placeholder: '모임소개 및 목표를 설명해주세요', controller: clubIntroController, focusNode: clubIntroFocusNode,
                  nextNode: clubLimitFocusNode,
                  isIntro: true
                ),
                detailTitle('인원 수 (1~15명)'),
                _setupTextField(placeholder: '0', controller: clubLimitController, focusNode: clubLimitFocusNode,
                  isNext: false, isNum: true
                ),
                sizedBox(36),
                GestureDetector(
                  onTap: () {_nextStep();},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: _fieldComplete ? Color(0xff0958c5) : Color(0xffd1d5d9)
                    ),
                    height: 52 * responsiveScale,
                    child: Center(child: Text('개설하기', style: textStyle(color: Colors.white, weight: 600, size: 16.0))),
                  )
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
      onTap: _modifyImage,
      child: Container(
        width: 333 * responsiveScale,
        height: 160 * responsiveScale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(color: Color(0xffe4e4e4), width: 1),
        ),
        child: _clubImage == null ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('asset/image/icoPhoto.svg', width: 36, height: 36),
              sizedBox(4),
              Text('사진을 등록해주세요', style: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0))
            ],
          )
        ) : Image.file(File(_clubImage!.path), width: 333 * responsiveScale, height: 160 * responsiveScale, fit: BoxFit.contain)
      )
    );
  }

  _setupTextField({required String placeholder, required TextEditingController controller, required FocusNode focusNode, bool isNext=true, FocusNode? nextNode, bool isNum=false, bool isIntro=false}) {
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
      keyboardType: isNum ? TextInputType.number : (isIntro ? TextInputType.multiline : TextInputType.text),
      textInputAction: isIntro ? TextInputAction.newline : (isNext ? TextInputAction.next : TextInputAction.done),
      maxLines: isIntro ? null : 1,
      onChanged: (value) {
        setState(() {
          print(isIntro);
          _fieldComplete = (clubNameController.text != '' && clubIntroController.text != '' && (clubLimitController.text != '' && int.parse(clubLimitController.text) > 0));
        });
      },
      onSubmitted: (value) {
        if(isIntro) return;
        else if(nextNode != null) nextNode.requestFocus();
        else _nextStep();
      },
    );
  }

  Future _modifyImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final _pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        print('hello');
        _clubImage = _pickedImage;
      } else {
        print('No image selected.');
      }
    });
  }

  void _nextStep() {
    if(_fieldComplete) {
      // TODO : club creation done
    }
  }
}
