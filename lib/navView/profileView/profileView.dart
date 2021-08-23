import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';

class ProfileItem {
  String? profileUrl;
  String name;
  ProfileItem({this.profileUrl, required this.name});
}
ProfileItem testUser = ProfileItem(name: '테스트계정');

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileView();
}
class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    ProfileItem _user = testUser;
    return Scaffold(
      appBar: MainViewAppBar(title: '더보기', back: false),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        child: Column(
          children: [
            sizedBox(28),
            GestureDetector(
              onTap: () {
                //계정설정 페이지
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36 * responsiveScale),
                    child: _user.profileUrl == null
                      ? Image.asset('asset/loginView/profile.png', width: 72 * responsiveScale, height: 72 * responsiveScale,)
                      : Image.network(_user.profileUrl!, width: 72 * responsiveScale, height: 72 * responsiveScale, fit: BoxFit.cover,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - (130 * responsiveScale),
                    margin: EdgeInsets.only(left: 16 * responsiveScale),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_user.name, style: textStyle(weight: 700, size: 18.0), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
                        sizedBox(6),
                        Text('계정 설정', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0))
                      ],
                    )
                  )
                ]
              )
            ),
            sizedBox(24),
          ] + List<Widget>.generate(_menuItemList.length, (index) {
            var _menuItem = _menuItemList[index];
            return GestureDetector(
              onTap: () {
                if(_menuItem.linkUrl == null) {
                  // 공지사항 게시판??
                } else {
                  // 외부 링크 통해 약관 등 webview
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 42 * responsiveScale,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_menuItem.title, style: textStyle(weight: 400, size: 16.0)),
                    SvgPicture.asset('asset/loginView/iconArrow.svg', width: 20, height: 20, color: Colors.black),
                  ]
                )
              )
            );
          })
        )
      )
    );
  }
}

class MenuItem {
  String title;
  String? linkUrl;
  MenuItem({required this.title, this.linkUrl});
}
List<MenuItem> _menuItemList = [
  MenuItem(title: '공지사항'),
  MenuItem(title: '고객센터', linkUrl: 'https://www.github.com'),
  MenuItem(title: '이용약관', linkUrl: 'https://www.github.com'),
  MenuItem(title: '개인정보처리방침', linkUrl: 'https://www.github.com')
];