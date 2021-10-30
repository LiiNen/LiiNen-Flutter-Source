import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailView.dart';

class ClubCardObject {
  String? thumbnailUrl;
  String clubTitle;
  String clubContext;
  int current;
  int total;
  bool isRecruit;
  ClubCardObject({
    this.thumbnailUrl, required this.clubTitle, required this.clubContext,
    this.current=0, this.total=5, this.isRecruit=false,
  });
}

class ClubCardContainer extends StatefulWidget {
  final dynamic _result;
  ClubCardContainer(this._result);
  @override
  State<ClubCardContainer> createState() => _ClubCardContainer(_result);
}
class _ClubCardContainer extends State<ClubCardContainer> {
  dynamic _result;
  _ClubCardContainer(this._result);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {navigatorPush(context: context, widget: ClubDetailView(_result['_id']));},
      child: Container(
        decoration: shadowBoxDecoration(),
        width: MediaQuery.of(context).size.width, height: 152,
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 128, height: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(
                  image: AssetImage('asset/category/it.jpeg'),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8 * responsiveScale),
                // padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(getCategoryName(_result['category']), style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0), textAlign: TextAlign.left,),
                    sizedBox(6),
                    Text(_result['name'], style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sizedBox(4),
                    Text(_result['introduction'], style: textStyle(weight: 400, size: 10.0), textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0, bottom: 0 * responsiveScale,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10 * responsiveScale),
                                SvgPicture.asset('asset/image/icoUser.svg', width: 10, height: 10, color: Colors.black),
                                SizedBox(width: 4 * responsiveScale),
                                Text('(${_result['personsCount']}/${_result['maxPerson']}명)', style: textStyle(weight: 600, size: 10.0),),
                                SizedBox(width: 6 * responsiveScale),
                                _result['isRecruiting']
                                  ? Text('모집중', style: textStyle(color: Color(0xff0958c5), weight: 700, size: 16.0))
                                  : Text('모집마감', style: textStyle(color: Color(0xff636c73), weight: 700, size: 16.0))
                              ],
                            )
                          ),
                        ],
                      )
                    )
                  ]
                )
              )
            ),
          ],
        ),
      )
    );
  }
}
