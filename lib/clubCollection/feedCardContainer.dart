import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';

class FeedCardObject {
  String feedTitle;
  String feedContext;
  String clubTitle;
  String userName;
  int likeCount;
  int commentCount;
  FeedCardObject({
    required this.feedTitle, required this.feedContext, required this.clubTitle, required this.userName,
    required this.likeCount, required this.commentCount
  });
}

List<FeedCardObject> testFeedObjectList = [
  FeedCardObject(feedTitle: '코딩같이할사람', feedContext: '코딩같이할사람구해영', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
  FeedCardObject(feedTitle: '피드 제목, 최대 1줄, ellipsis overflow를 적용하여 이후는 점으로', feedContext: '안녕하세요 두번째 피드 예시의 모임 설명 내용에 해당되는 텍스트입니다. 해당 필드는 최대 3줄까지만 표기되며 이후는 점으로 축약되어 표기됩니다. 이후 내용은 모두 보이지 않게 됩니다.', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
  FeedCardObject(feedTitle: '코딩같이할사람', feedContext: '코딩같이할사람구해영', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
  FeedCardObject(feedTitle: '코딩같이할사람', feedContext: '코딩같이할사람구해영', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
  FeedCardObject(feedTitle: '코딩같이할사람', feedContext: '코딩같이할사람구해영', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
  FeedCardObject(feedTitle: '코딩같이할사람', feedContext: '코딩같이할사람구해영', clubTitle: '소프트웨어마에스트로', userName: '소마12기연수생', likeCount: 1, commentCount: 2),
];

class FeedCardContainer extends StatefulWidget {
  final FeedCardObject _feedObject;
  FeedCardContainer(this._feedObject);
  @override
  State<FeedCardContainer> createState() => _FeedCardContainer(_feedObject);
}
class _FeedCardContainer extends State<FeedCardContainer> {
  FeedCardObject feedObject;
  _FeedCardContainer(this.feedObject);

  TextStyle greyStyle = textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadowBoxDecoration(),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
      padding: EdgeInsets.symmetric(vertical: 20 * responsiveScale, horizontal: 12 * responsiveScale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(feedObject.feedTitle, style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          sizedBox(4),
          Text(feedObject.feedContext, style: textStyle(weight: 400, size: 10.0), textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          sizedBox(24),
          Text('${feedObject.clubTitle} · ${feedObject.userName}', style: greyStyle,),
          sizedBox(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('asset/image/heartIco.svg', width: 16, height: 16),
              SizedBox(width: 4),
              Text(feedObject.likeCount.toString(), style: greyStyle),
              SizedBox(width: 12),
              SvgPicture.asset('asset/image/messageIco.svg', width: 16, height: 16),
              SizedBox(width: 4),
              Text(feedObject.commentCount.toString(), style: greyStyle),
            ],
          )
        ],
      )
    );
  }
}