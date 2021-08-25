import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '알림', back: false),
      body: ListView.builder(
        itemCount: alarmItemList.length * 2,
        itemBuilder: (context, index) {
          if(index%2 == 1) return LineDivider(horizontalMargin: false,);
          var itemIndex = (index/2).floor();
          final item = alarmItemList[itemIndex];
          return Slidable(
            key: UniqueKey(),
            direction: Axis.horizontal,
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(),
              onDismissed: (actionType) {
                setState(() {removeAlarm(itemIndex);});
              },
            ),
            actionPane: SlidableScrollActionPane(),
            actionExtentRatio: 0.2,
            secondaryActions: [
              IconSlideAction(
                color: Color(0xffeb5847),
                onTap: () {setState(() {removeAlarm(itemIndex);});},
                iconWidget: Container(
                  child: Text('지우기', style: textStyle(color: Colors.white, weight: 400, size: 12.0))
                ),
              )
            ],
            child: GestureDetector(
              onTap: () => {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: item.thumbnailUrl == null
                        ? Image.asset('asset/loginView/profile.png', width: 36, height: 36,)
                        : Image.network(item.thumbnailUrl!, width: 36, height: 36, fit: BoxFit.cover,),
                    ),
                    Container(
                      width: maxWidth - 36 - 8 * responsiveScale,
                      margin: EdgeInsets.only(left: 8 * responsiveScale),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  removeAlarm(index) {
    alarmItemList.removeAt(index);
  }
}

List<AlarmItemObject> alarmItemList = [
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
  AlarmItemObject(context: '모각까가가가가가가ㅏ가가가가가가가가ㅏ', time: 60),
];