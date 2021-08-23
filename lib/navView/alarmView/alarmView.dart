import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/alarmView/alarmItemContainer.dart';
import 'package:my_flutter_source/main.dart';

class AlarmView extends StatefulWidget {
  @override
  State<AlarmView> createState() => _AlarmView();
}
class _AlarmView extends State<AlarmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '알림', back: false),
      body: ListView.builder(
        itemCount: alarmItemList.length,
        itemBuilder: (context, index) {
          final item = alarmItemList[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                alarmItemList.removeAt(index);
              });
            },
            child: GestureDetector(
              onTap: () => {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18 * responsiveScale),
                      child: item.thumbnailUrl == null
                        ? Image.asset('asset/loginView/profile.png', width: 36 * responsiveScale, height: 36 * responsiveScale,)
                        : Image.network(item.thumbnailUrl!, width: 36 * responsiveScale, height: 36 * responsiveScale, fit: BoxFit.cover,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - (86 * responsiveScale),
                      margin: EdgeInsets.only(left: 8 * responsiveScale),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.context, style: textStyle(weight: 400, size: 14.0), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
                          Text(item.time.toString(), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0), overflow: TextOverflow.ellipsis,)
                        ],
                      )
                    )
                  ],
                )
              )
            )
          );
        },
      ),
    );
  }
}

List<AlarmItemObject> alarmItemList = [
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
];