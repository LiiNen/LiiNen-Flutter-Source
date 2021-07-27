import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

void launchURL(_srcURL) async => await canLaunch(_srcURL) ? await launch(_srcURL) : throw 'url \"$_srcURL\" error';

void showToast(String message){
  Fluttertoast.showToast(msg: message,
      gravity: ToastGravity.BOTTOM
  );
}