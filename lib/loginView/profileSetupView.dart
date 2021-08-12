import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';

class ProfileSetupView extends StatefulWidget {
  @override
  State<ProfileSetupView> createState() => _ProfileSetupView();
}
class _ProfileSetupView extends State<ProfileSetupView> {
  final nameController = TextEditingController();
  PickedFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text('사진과 닉네임을 등록해주세요', style: textStyle(weight: 700, size: 20.0)),
                  SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: _modifyImage,
                      child: Stack(
                        children: [
                          Container(
                            width: 120, height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xffebebeb),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: _profileImage == null ? Image.asset('asset/loginView/profile.png') : Image.file(File(_profileImage!.path)),
                          ),
                          Positioned(
                            right: 5, bottom: 0,
                            child: Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(
                                color: const Color(0xffc2c6cd),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(child: Container(width: 14, height: 14, child: SvgPicture.asset('asset/loginView/icoCamera.svg', fit: BoxFit.fill,)))
                            )
                          )
                        ],
                      )
                    )
                  ),
                  SizedBox(height: 20),
                  Text('닉네임', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                  SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                        border: OutlineInputBorder(),
                        hintText: '닉네임을 입력해주세요'
                    ),
                    style: textStyle(weight: 600, size: 12.0),
                    onChanged: (value) {setState(() {});},
                  ),
                  SizedBox(height: 4),
                  Text('20자 이내로 입력할 수 있어요', style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0)),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: _nextStep,
                    child: Container(
                      height: 52,
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupView()));
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