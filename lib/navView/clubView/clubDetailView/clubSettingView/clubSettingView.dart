import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'clubMemberSettingView.dart';
import 'package:my_flutter_source/navView/homeView/clubCreationView/clubDetailSetupView.dart';

class ClubSettingView extends StatefulWidget {
  final dynamic result;
  ClubSettingView(this.result);

  @override
  State<ClubSettingView> createState() => _ClubSettingView(result);
}
class _ClubSettingView extends State<ClubSettingView> {
  dynamic result;
  _ClubSettingView(this.result);

  @override
  Widget build(BuildContext context) {
    print(result);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '모임설정', back: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: <Widget>[
            SizedBox(height: 28),
            settingItem(title: '모임정보 수정', route: ClubDetailSetupView('')),
            settingItem(title: '멤버 관리', route: ClubMemberSettingView(result)),
          ]
        )
      )
    );
  }

  settingItem({required String title, Widget? route}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(route != null) navigatorPush(context: context, widget: route);
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 47,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: textStyle(weight: 400, size: 16.0)),
                SvgPicture.asset('asset/loginView/iconArrow.svg', width: 20, height: 20, color: Colors.black),
              ]
            )
          ),
          LineDivider(horizontalMargin: false,)
        ]
      )
    );
  }
}