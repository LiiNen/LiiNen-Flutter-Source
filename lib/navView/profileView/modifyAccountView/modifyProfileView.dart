import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/loginWidgets.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/restApi/usersApi.dart';

import '../profileView.dart';

class ModifyProfileView extends StatefulWidget {
  @override
  State<ModifyProfileView> createState() => _ModifyProfileView();
}
class _ModifyProfileView extends State<ModifyProfileView> {
  final nameController = TextEditingController();
  final introController = TextEditingController();
  FocusNode introFocusNode = FocusNode();
  PickedFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: MainViewAppBar(title: '프로필 편집', back: true),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                sizedBox(16),
                TitleContainer(title: '자신을 멋지게 소개해보세요', size: 20.0, margin: false),
                sizedBox(8),
                Center(
                  child: GestureDetector(
                    onTap: _modifyImage,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60 * responsiveScale),
                          child: _profileImage == null
                            ? Image.asset('asset/loginView/profile.png', width: 120 * responsiveScale, height: 120 * responsiveScale,)
                            : Image.file(File(_profileImage!.path), width: 120 * responsiveScale, height: 120 * responsiveScale, fit: BoxFit.cover,),
                        ),
                        Positioned(
                          right: 5 * responsiveScale, bottom: 0,
                          child: Container(
                            width: 28 * responsiveScale, height: 28 * responsiveScale,
                            decoration: BoxDecoration(
                              color: const Color(0xffc2c6cd),
                              borderRadius: BorderRadius.circular(14 * responsiveScale),
                            ),
                            child: Center(child: Container(width: 14 * responsiveScale, height: 14 * responsiveScale, child: SvgPicture.asset('asset/loginView/icoCamera.svg', fit: BoxFit.fill,)))
                          )
                        )
                      ],
                    )
                  )
                ),
              ] + nameField() + introField() + phoneField() + [
                sizedBox(36),
                confirmButton(title: '수정하기', confirmAction: confirm, condition: nameController.text != '' || introController.text != ''),
              ]
            )
          )
        )
      )
    );
  }

  void confirm() async {
    var response = await patchUsers(userId: userInfo['_id'], name: 'hello');
    print(response);
  }

  List<Widget> nameField() {
    return [
      sizedBox(20),
      loginSubtitle('닉네임'),
      sizedBox(8),
      TextField(
        controller: nameController,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
          enabledBorder: enabledBorderDefault(),
          focusedBorder: focusedBorderDefault(),
          hintText: userProfile['name'],
          hintStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0),
        ),
        style: textStyle(weight: 600, size: 12.0),
        textInputAction: TextInputAction.done,
        onChanged: (value) {setState(() {});},
        onSubmitted: (value) {introFocusNode.requestFocus();},
      ),
      sizedBox(4),
      Text('20자 이내로 입력할 수 있어요', style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0)),
    ];
  }
  List<Widget> introField() {
    return [
      sizedBox(24),
      loginSubtitle('자기소개'),
      sizedBox(8),
      TextField(
        controller: introController,
        focusNode: introFocusNode,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
          enabledBorder: enabledBorderDefault(),
          focusedBorder: focusedBorderDefault(),
          hintText: userProfile['introduce'],
          hintStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0),
        ),
        style: textStyle(weight: 600, size: 12.0),
        textInputAction: TextInputAction.done,
        onChanged: (value) {setState(() {});},
      ),
      sizedBox(4),
      Text('나이와 직업, 도시 등을 자유롭게 소개하세요', style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0)),
    ];
  }
  List<Widget> phoneField() {
    return [
      sizedBox(24),
      loginSubtitle('이메일'),
      sizedBox(8),
      TextField(
        readOnly: true,
        decoration: InputDecoration(
          fillColor: Color(0xfff5f5f5),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
          enabledBorder: disabledBorder(),
          focusedBorder: disabledBorder(),
          hintText: userProfile['email'],
          hintStyle: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0),
        ),
      ),
    ];
  }

  Future _modifyImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final _pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        print('hello');
        _profileImage = _pickedImage;
      } else {
        print('No image selected.');
      }
    });
  }
}