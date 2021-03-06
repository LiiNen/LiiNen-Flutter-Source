import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/restApi/restApi.dart';
import 'package:my_flutter_source/restApi/usersApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'containerCollection.dart';
import 'loginView/categorySetupView.dart';
import 'navView/profileView/profileView.dart';

void launchURL(_srcURL) async => await canLaunch(_srcURL) ? await launch(_srcURL) : throw 'url \"$_srcURL\" error';

void showToast(String message){
  Fluttertoast.showToast(msg: message,
      gravity: ToastGravity.BOTTOM
  );
}

TextStyle textStyle({color: Colors.black, weight: int, size: double}) {
  FontWeight fontWeight = FontWeight.normal;
  switch(weight) {
    case 400:
      fontWeight = FontWeight.w400;
      break;
    case 600:
      fontWeight = FontWeight.w600;
      break;
    case 700:
      fontWeight = FontWeight.w700;
      break;
  }
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontFamily: "AppleSDGothicNeo",
    fontStyle:  FontStyle.normal,
    fontSize: size
  );
}

BoxDecoration shadowBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    boxShadow: [BoxShadow(
        color: Color(0x338d979e),
        offset: Offset(0, 0),
        blurRadius: 30,
        spreadRadius: 0
    )],
    color: Colors.white,
  );
}

void scrollOnFocus(scrollController, height) {
  scrollController.animateTo(height, duration: new Duration(seconds: 1), curve: Curves.ease);
}

bool passwordRegexCheck(String input) {
  return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(input);
}
bool emailRegexCheck(String input) {
  return RegExp(r'^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$').hasMatch(input);
}
bool phoneRegexCheck(String input) {
  return RegExp(r'^(010)[0-9]{8}').hasMatch(input) && input.length == 11;
}
bool authRegexCheck(String input) {
  var _length = 6;
  return RegExp(r'^[0-9]{6}').hasMatch(input) && input.length == _length;
}

enabledBorderDefault() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: BorderSide(color: Color(0xffe4e4e4), width: 1),
  );
}

focusedBorderDefault() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: BorderSide(color: Color(0xff0958c5), width: 1),
  );
}

inputBorderWarning() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: BorderSide(color: Color(0xffd93826), width: 1),
  );
}

disabledBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: BorderSide(color: Color(0xfff5f5f5), width: 1)
  );
}

constraint(height) {
  return SizedBox(height: height * responsiveScale);
}

swiperPagination() {
  return SwiperPagination(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.all(4),
    builder: DotSwiperPaginationBuilder(
      color: Color(0xffd9dee7), size: 6.0,
      activeColor: Color(0xff0058cc), activeSize: 6.0
    )
  );
}

textFieldClear(TextEditingController controller) {
  controller.clear();
}

selectedBorderColor() {return Color(0xff0958c5);}
unselectedBorderColor() {return Color(0xffd3d7df);}
selectedFillColor() {return Color(0xff0958c5);}
unselectedFillColor() {return Color(0xffffffff);}
selectedTextColor() {return Color(0xffffffff);}
unselectedTextColor() {return Color(0xffd1d5d9);}

navigatorPush({required context, required widget, replacement=false, all=false}) {
  replacement
    ? all
      ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false)
      : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget))
    : Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

showExitDialog(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => ExitDialog()
  )) ?? false;
}

showAlertDialog(BuildContext context, String title) async {
  return (await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 112,
              child: Center(
                child: Text(title, style: textStyle(weight: 400, size: 16.0))
              )
            ),
            IntrinsicHeight(
              child: Container(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Container(child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {Navigator.of(context).pop(false);},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffebebeb), width: 1),
                          color: Color(0xfffbfbfb),
                        ),
                        child: Center(
                          child: Text('??????', style: textStyle(color: Color(0xff0958c5), weight: 600, size: 14.0))
                        )
                      )
                    )))
                  ]
                )
              )
            )
          ]
        )
      )
    )
  )) ?? false;
}

setToken({String token='', String id=''}) async {
  final pref = await SharedPreferences.getInstance();
  if(token != '' && id == '') {
    pref.setString('token', token);
    authToken['Authorization'] = token;
  }
  if (token != '') userInfo = Jwt.parseJwt(token);
  else if (id == '') {
    pref.setString('token', '');
    authToken['Authorization'] = '';
  }
  userProfile = await getUsersById(userId: (id != '') ? id : userInfo['_id']);
}

getCategoryName(String id) {
  final name = categories.firstWhere((e) => e['_id'] == id);
  return name['name'];
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('$path');
  final buffer = byteData.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path + '/temp_img.tmp';
  final file = File(tempPath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
  );
  return file;
}

void loadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      const oneSec = Duration(seconds:1);
      Timer.periodic(oneSec, (Timer t) {
        if(authToken['Authorization'] != '' || isLoading == false) {
          Navigator.pop(context);
          t.cancel();
        }
      });
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('????????? ?????? ????????????...'),
          ],
        ),
      );
    },
  );
}

reloadUserData() async {
  final pref = await SharedPreferences.getInstance();
  String _token = pref.getString('token')!;
  await setToken(token: _token);
}

String httpsToHttp(String target) {
  return target.replaceAll('https', 'http');
}

String timeParser(String target) {
  var afternoon = false;
  var temp = target.split('T');
  var date = temp[0].split('-');
  var time = temp[1].split('.')[0].split(':');
  if(int.parse(time[0]) > 12) {
    afternoon = true;
    time[0] = '${int.parse(time[0]) - 12}';
  }
  if(time[0].length == 1) time[0] = '0${time[0]}';
  if(time[0] == '00') time[0] = '12';
  return '${date[0]}??? ${date[1]}??? ${date[2]}??? '
    + (afternoon ? '??????' : '??????')
    + ' ${time[0]}:${time[1]}';
}