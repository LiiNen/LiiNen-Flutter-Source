import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/navView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

class ClubDetailSetupView extends StatefulWidget {
  final String id;
  final dynamic result;
  ClubDetailSetupView({required this.id, this.result});

  @override
  State<ClubDetailSetupView> createState() => _ClubDetailSetupView(id, result);
}
class _ClubDetailSetupView extends State<ClubDetailSetupView> {
  String categoryId;
  dynamic result;
  _ClubDetailSetupView(this.categoryId, this.result);

  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubIntroController = TextEditingController();
  TextEditingController clubLimitController = TextEditingController();

  FocusNode clubNameFocusNode = FocusNode();
  FocusNode clubIntroFocusNode = FocusNode();
  FocusNode clubLimitFocusNode = FocusNode();

  File? _clubImage;
  bool _fieldComplete = false;

  @override
  Widget build(BuildContext context) {
    print(result!=null);
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
                  placeholder: result == null ? '모임이름을 입력해주세요' : result['name'],
                  controller: clubNameController, focusNode: clubNameFocusNode,
                  nextNode: clubIntroFocusNode,
                ),
                detailTitle('모임 소개'),
                _setupTextField(
                  placeholder: result == null ? '모임소개 및 목표를 설명해주세요' : result['introduction'],
                  controller: clubIntroController, focusNode: clubIntroFocusNode,
                  nextNode: clubLimitFocusNode,
                  isIntro: true
                ),
                detailTitle('인원 수 (1~15명)'),
                _setupTextField(
                  placeholder: result == null ? '0' : result['maxPerson'].toString(),
                  controller: clubLimitController, focusNode: clubLimitFocusNode,
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
                    child: Center(
                      child: Text(result != null ? '변경하기' : '개설하기', style: textStyle(color: Colors.white, weight: 600, size: 16.0))
                    ),
                  )
                ),
                sizedBox(10),
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
        width: maxWidth,
        height: maxWidth / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(color: Color(0xffe4e4e4), width: 1),
        ),
        child: _clubImage == null ?
          (result == null ?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('asset/image/icoPhoto.svg', width: 36, height: 36),
                  sizedBox(4),
                  Text('사진을 등록해주세요', style: textStyle(color: Color(0xffd1d5d9), weight: 400, size: 12.0))
                ],
              )
            ) : Image.network(httpsToHttp(result['imageUrls'][0]), width: 333 * responsiveScale, height: 160 * responsiveScale, fit: BoxFit.cover, )
          ) : Image.file(File(_clubImage!.path), width: 333 * responsiveScale, height: 160 * responsiveScale, fit: BoxFit.cover)
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
          if(result == null) _fieldComplete = (clubNameController.text != '' && clubIntroController.text != '' && (clubLimitController.text != '' && int.parse(clubLimitController.text) > 0));
          else if(result != null) {
            _fieldComplete = (_clubImage != null) || (clubNameController.text != '') || (clubIntroController.text != '') || ((clubLimitController.text != '') && (int.parse(clubLimitController.text) > 0));
          }
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
        setState(() {
          _clubImage = File(_pickedImage.path);
          if(result == null) _fieldComplete = (clubNameController.text != '' && clubIntroController.text != '' && (clubLimitController.text != '' && int.parse(clubLimitController.text) > 0));
          else if(result != null) {
            _fieldComplete = (_clubImage != null) || (clubNameController.text != '') || (clubIntroController.text != '') || ((clubLimitController.text != '') && (int.parse(clubLimitController.text) > 0));
          }
        });
      } else {
        print('No image selected.');
      }
    });
  }

  void _nextStep() async {
    if(_fieldComplete || result != null) {
      if(result != null) {
        result = await patchMeetings(
          meetingId: result['_id'],
          name: clubNameController.text != '' ? clubNameController.text : result['name'],
          introduction: clubIntroController.text != '' ? clubIntroController.text : result['introduction'],
          maxPerson: clubLimitController.text != '' ? clubLimitController.text : result['maxPerson'].toString(),
          clubImage: _clubImage
        );
        await reloadUserData();
        if(result) {
          showToast('모임 변경 완료!');
        }
      }
      else {
        var result;
        if(_clubImage == null) {
          File _temp = await getImageFileFromAssets('asset/loginView/bannerImg.png');
          result = await postMeetings(name: clubNameController.text, introduction: clubIntroController.text, category: categoryId, maxPerson: clubLimitController.text, clubImage: _temp);
          await reloadUserData();
        }
        else {
          result = await postMeetings(name: clubNameController.text, introduction: clubIntroController.text, category: categoryId, maxPerson: clubLimitController.text, clubImage: _clubImage!);
          await reloadUserData();
        }
        if(result) {
          showToast('모임 생성 완료!');
          navigatorPush(context: context, widget: NavView(selectedIndex: 2,), replacement: true, all: true);
        }
      }
    }
  }
}
