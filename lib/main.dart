import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'loginView/loginView.dart';
import 'navView/navView.dart';

void main()=> runApp(MyApp());

double responsiveScale = 1.0;

class MyApp extends StatelessWidget {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainRouter(),
      //   home: NavView(),
    );
  }
}

class MainRouter extends StatefulWidget {
  @override
  State<MainRouter> createState() => _MainRouter();
}
class _MainRouter extends State<MainRouter> {
  bool? _loginState;

  @override
  initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 2), _checkLogin);
  }
  
  _checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _loginState = pref.getBool('login') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width / 375;
    var b = MediaQuery.of(context).size.height / 812;
    responsiveScale = a < b ? a : b;
    if(_loginState != null && _loginState!){
      return MaterialApp(
        home: NavView()
      );
    }
    else if (_loginState != null && !_loginState!) {
      return MaterialApp(
        home: LoginView()
      );
    }
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'asset/image/splashLogo.svg'
        )
      )
    );
  }
}

List<String> categoryNameList = ['운동', '공예', '예술', '자기계발', 'IT', '오락', '자유주제'];
List<String> categoryDetailList = ['스포츠/피트니스', 'DIY', '악기/그림', '독서/스터디', '개발/디자인', '온라인/보드게임', '기타'];
List<String> categoryFullList = List<String>.generate(categoryNameList.length, (index) {
  return '${categoryNameList[index]} (${categoryDetailList[index]})';
});