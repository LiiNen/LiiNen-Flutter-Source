import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';

import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'modifyProfileView.dart';
import 'deleteAccountView.dart';

class ModifyAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '계정 설정', back: true,),
      body: Container(
        padding: EdgeInsets.only(top: 28 * responsiveScale),
        child: Column(
          children: List<Widget>.generate(_modifyItemList.length, (index) {
            var _modifyItem = _modifyItemList[index];
            return GestureDetector(
              onTap: () {
                if(_modifyItem.route == null) {
                  // TODO : 곧바로 로그아웃
                } else {
                  navigatorPush(context: context, widget: _modifyItem.route);
                }
              },
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 42 * responsiveScale,
                    height: 47,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_modifyItem.title, style: textStyle(weight: 400, size: 16.0)),
                        SvgPicture.asset('asset/loginView/iconArrow.svg', width: 20, height: 20, color: Colors.black),
                      ]
                    )
                  ),
                  LineDivider(horizontalMargin: true,)
                ]
              )
            );
          })
        )
      )
    );
  }
}

class ModifyItem {
  String title;
  Widget? route;
  ModifyItem({required this.title, this.route});
}
List<ModifyItem> _modifyItemList = [
  ModifyItem(title: '프로필 편집', route: ModifyProfileView()),
  ModifyItem(title: '로그아웃'),
  ModifyItem(title: '계정탈퇴', route: DeleteAccountView()),
];