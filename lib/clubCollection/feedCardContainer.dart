import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailView.dart';

class FeedCardContainer extends StatefulWidget {
  final dynamic feedObject;
  final bool isSuggestion;
  FeedCardContainer({this.feedObject, this.isSuggestion=false});
  @override
  State<FeedCardContainer> createState() => _FeedCardContainer(feedObject, isSuggestion);
}
class _FeedCardContainer extends State<FeedCardContainer> {
  dynamic feedObject;
  bool isSuggestion;
  _FeedCardContainer(this.feedObject, this.isSuggestion);

  TextStyle greyStyle = textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(isSuggestion == true) {
          navigatorPush(context: context, widget: ClubDetailView(id: feedObject['meeting']));
        }
      },
      child: Container(
        decoration: shadowBoxDecoration(),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        padding: EdgeInsets.symmetric(vertical: 20 * responsiveScale, horizontal: 12 * responsiveScale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(feedObject['title'], style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            sizedBox(4),
            Text(feedObject['contents'], style: textStyle(weight: 400, size: 10.0), textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            sizedBox(24),
            Text('${feedObject['meeting']['name']} ?? ${feedObject['author']['name']}', style: greyStyle,),
            sizedBox(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('asset/image/heartIco.svg', width: 16, height: 16),
                SizedBox(width: 4),
                Text(feedObject['likesCount'].toString(), style: greyStyle),
                SizedBox(width: 12),
                SvgPicture.asset('asset/image/messageIco.svg', width: 16, height: 16),
                SizedBox(width: 4),
                Text(feedObject['commentsCount'].toString(), style: greyStyle),
              ],
            )
          ],
        )
      )
    );
  }
}