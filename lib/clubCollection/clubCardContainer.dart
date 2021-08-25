import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';

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

List<ClubCardObject> testObjectList = [
  ClubCardObject(clubTitle: '첫번째 모임 예', clubContext: '안녕하세요 첫번째 모임 예시의 모임 설명 내용에 해당되는 텍스트입니다. 해당 필드는 최대 3줄까지만 표기되며 이후는 점으로 축약되어 표기됩니다. 이후 내용은 모두 보이지 않게 됩니다.', current: 4, total: 10),
  ClubCardObject(clubTitle: '모임 제목, 최대 1줄, ellipsis overflow를 적용하여 이후는 점으로', clubContext: 'qwerqwreqwerqwreqerqwerqwerqwerqwreqwerqwerqwer', current: 1, total: 3, isRecruit: true),
  ClubCardObject(clubTitle: 'third', clubContext: 'zxcvznxmcvnzmxcvnzmxcvnmzxcvnmzxcnvmzxncvmnzcxmvnzmvnmxzcnvmzxnv', current: 13, total: 22),
  ClubCardObject(clubTitle: 'fourth', clubContext: 'a'),
  ClubCardObject(clubTitle: 'fifth', clubContext: 's'),
  ClubCardObject(clubTitle: 'sixth', clubContext: 'e'),
  ClubCardObject(clubTitle: 'seventh', clubContext: 'w'),
];

class ClubCardContainer extends StatefulWidget {
  final ClubCardObject clubObject;
  ClubCardContainer(this.clubObject);
  @override
  State<ClubCardContainer> createState() => _ClubCardContainer(clubObject);
}
class _ClubCardContainer extends State<ClubCardContainer> {
  ClubCardObject clubObject;
  _ClubCardContainer(this.clubObject);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text('클럽 분류 들어갈 위치', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0), textAlign: TextAlign.left,),
                  sizedBox(6),
                  Text(clubObject.clubTitle, style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBox(4),
                  Text(clubObject.clubContext, style: textStyle(weight: 400, size: 10.0), textAlign: TextAlign.left,
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
                              Text('(${clubObject.current}/${clubObject.total}명)', style: textStyle(weight: 600, size: 10.0),),
                              SizedBox(width: 6 * responsiveScale),
                              clubObject.isRecruit
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
    );
  }
}
