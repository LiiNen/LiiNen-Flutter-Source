import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter_source/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

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