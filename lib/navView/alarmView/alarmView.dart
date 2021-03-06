import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/alarmView/alarmItemContainer.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailView.dart';
import 'package:my_flutter_source/restApi/alarmApi.dart';

class AlarmView extends StatefulWidget {
  @override
  State<AlarmView> createState() => _AlarmView();
}
class _AlarmView extends State<AlarmView> {

  List<dynamic> alarmList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getAlarm();
  }

  void _getAlarm() async {
    var _temp = await getAlarm(userId: userInfo['_id']);
    if(_temp != null) {
      setState(() {
        alarmList = _temp;
        print(_temp);
        isLoaded = true;
      });
    }
    else {
      showToast('네트워크를 확인해주세요.');
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '알림', back: false),
      body: ListView.builder(
        itemCount: alarmList.length * 2,
        itemBuilder: (context, index) {
          if(index%2 == 1) return LineDivider(horizontalMargin: false,);
          var itemIndex = (index/2).floor();
          final item = alarmList[itemIndex];
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
              behavior: HitTestBehavior.translucent,
              onTap: () => {
                navigatorPush(context: context, widget: ClubDetailView(id: item['meeting']))
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(httpsToHttp(item['imageUrl']), width: 36, height: 36, fit: BoxFit.cover,),
                    ),
                    Container(
                      width: maxWidth - 36 - 8 * responsiveScale,
                      margin: EdgeInsets.only(left: 8 * responsiveScale),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['contents'], style: textStyle(weight: 400, size: 14.0), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
                          Text(timeParser(item['createdAt']), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0), overflow: TextOverflow.ellipsis,)
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

  removeAlarm(index) async {
    var result = await deleteAlarm(alarmId: alarmList[index]['_id']);
    if(result == true) {
      setState(() {
        alarmList.removeAt(index);
      });
    }
    else showToast('네트워크 상태를 확인해주세요');
  }
}
