import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/categorySetupView.dart';

import 'package:my_flutter_source/main.dart';

class ProfileSetupView extends StatefulWidget {
  @override
  State<ProfileSetupView> createState() => _ProfileSetupView();
}
class _ProfileSetupView extends State<ProfileSetupView> {
  final nameController = TextEditingController();
  PickedFile? _profileImage;

  // TODO : overflow 37 pixel in android device when keyboard up
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                  SizedBox(height: 24 * responsiveScale),
                  Text('사진과 닉네임을 등록해주세요', style: textStyle(weight: 700, size: 20.0)),
                  SizedBox(height: 24 * responsiveScale),
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
                  SizedBox(height: 20 * responsiveScale),
                  Text('닉네임', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                  SizedBox(height: 8 * responsiveScale),
                  TextField(
                    controller: nameController,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                      enabledBorder: enabledBorderDefault(),
                      focusedBorder: focusedBorderDefault(),
                      hintText: '닉네임을 입력해주세요'
                    ),
                    style: textStyle(weight: 600, size: 12.0),
                    onChanged: (value) {setState(() {});},
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {_nextStep();},
                  ),
                  SizedBox(height: 4 * responsiveScale),
                  Text('20자 이내로 입력할 수 있어요', style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0)),
                  SizedBox(height: 40 * responsiveScale),
                  GestureDetector(
                    onTap: _nextStep,
                    child: Container(
                      height: 52 * responsiveScale,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(4)
                        ),
                        color: nameController.text != '' ? Color(0xff0958c5) : Color(0xffd1d5d9)
                      ),
                      child: Center(child: Text('다음으로', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                    )
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }

  void _nextStep() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategorySetupView()));
  }

  // TODO: m1 이외에서 체크 필요
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