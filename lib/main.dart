import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/restApi/categoriesApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'loginView/loginView.dart';
import 'navView/navView.dart';
import 'navView/profileView/profileView.dart';

void main()=> runApp(MyApp());

double responsiveScale = 1.0;
double maxWidth = 0.0;

Map<String, dynamic> userInfo = {

};

class MyApp extends StatelessWidget {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainRouter(),
      //   home: NavView(),
    );
  }
}

var categories = [];
var categoriesString;

class MainRouter extends StatefulWidget {
  @override
  State<MainRouter> createState() => _MainRouter();
}
class _MainRouter extends State<MainRouter> {
  bool? _loginState;

  @override
  initState() {
    super.initState();
    _getCategories();
    new Future.delayed(new Duration(seconds: 2), _checkLogin);
  }
  
  _checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _loginState = (pref.getString('token') != '');
    });

    String _token = pref.getString('token') ?? '';
    await setToken(token: _token);
    print('유저프로필');
    print(userProfile);
  }

  _getCategories() async {
    var _temp = await getCategories();
    setState(() {
      categories = _temp;
      categoriesString = categories.map((e) {
        return e['name'];
      }).toList();
      print(categories);
      print(categoriesString);
    });
  }

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width / 375;
    var b = MediaQuery.of(context).size.height / 812;
    responsiveScale = a < b ? a : b;
    maxWidth = MediaQuery.of(context).size.width - 42 * responsiveScale;
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
