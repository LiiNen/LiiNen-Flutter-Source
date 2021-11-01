import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/categorySetupView.dart';
import 'package:my_flutter_source/loginView/loginWidgets.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';

class ProfileSetupView extends StatefulWidget {
  final String email;
  final String password;
  ProfileSetupView(this.email, this.password);

  @override
  State<ProfileSetupView> createState() => _ProfileSetupView(email, password);
}
class _ProfileSetupView extends State<ProfileSetupView> {
  String email;
  String password;
  _ProfileSetupView(this.email, this.password);

  final nameController = TextEditingController();
  final introController = TextEditingController();
  FocusNode introFocusNode = FocusNode();
  File? _profileImage;

  // TODO : overflow 37 pixel in android device when keyboard up
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: LoginViewAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21  * responsiveScale),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox(24),
                    loginTitle('사진과 닉네임을 등록해주세요'),
                    sizedBox(24),
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
                  ] + nameField() + introField() + [
                    sizedBox(40),
                    confirmButton(title: '다음으로', confirmAction: _nextStep, condition: nameController.text != '')
                  ],
                ),
              ],
            )
          )
        )
      )
    );
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
          hintText: '닉네임을 입력해주세요',
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
          hintText: '자기소개를 입력해주세요',
          hintStyle: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0),
        ),
        style: textStyle(weight: 600, size: 12.0),
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {_nextStep();},
      ),
      sizedBox(4),
      Text('나이와 직업, 도시 등을 자유롭게 소개하세요', style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0)),
    ];
  }


  void _nextStep() async {
    if(nameController.text != '') {
      if(_profileImage == null) {
        _profileImage = await getImageFileFromAssets('asset/loginView/profile.png');
      }
      navigatorPush(context: context, widget: CategorySetupView(nameController.text, email, password, introController.text, _profileImage!));
    }
  }

  // TODO: m1 이외에서 체크 필요
  Future _modifyImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final _pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        _profileImage = File(_pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }
}