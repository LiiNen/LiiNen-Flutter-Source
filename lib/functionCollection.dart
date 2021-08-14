import 'package:flutter/material.dart';
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