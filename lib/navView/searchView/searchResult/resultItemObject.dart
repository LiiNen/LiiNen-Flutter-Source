import 'package:flutter/material.dart';

class ResultClubObject {
  String? thumbnailUrl;
  String clubTitle;
  String? clubContext;
  ResultClubObject({this.thumbnailUrl, required this.clubTitle, this.clubContext});
}

List<ResultClubObject> testObjectList = [
  ResultClubObject(clubTitle: 'first'),
  ResultClubObject(clubTitle: 'second', thumbnailUrl: 'https://liinen.github.io/Team7-Blog/images/home/home_banner.png'),
  ResultClubObject(clubTitle: 'third', thumbnailUrl: 'https://liinen.github.io/Team7-Blog/images/home/home_banner.png'),
  ResultClubObject(clubTitle: 'fourth'),
  ResultClubObject(clubTitle: 'fifth'),
  ResultClubObject(clubTitle: 'sixth', thumbnailUrl: 'https://liinen.github.io/Team7-Blog/images/home/home_banner.png'),
  ResultClubObject(clubTitle: 'seventh'),
];

class ResultClubContainer extends StatefulWidget {
  @override
  State<ResultClubContainer> createState() => _ResultClubContainer();
}
class _ResultClubContainer extends State<ResultClubContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<ResultClubItem>.generate(testObjectList.length, (index) {
        return ResultClubItem(testObjectList[index]);
      }),
    );
  }
}

class ResultClubItem extends StatefulWidget {
  final ResultClubObject _clubObject;
  ResultClubItem(this._clubObject);
  @override
  State<ResultClubItem> createState() => _ResultClubItem(_clubObject);
}
class _ResultClubItem extends State<ResultClubItem> {
  ResultClubObject _clubObject;
  _ResultClubItem(this._clubObject);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: (
        Row(
          children: [
            FlutterLogo(size: 200),
            Expanded(
              child: Column(
                children: [Text(_clubObject.clubTitle)]
                    + (_clubObject.clubContext != null ? [Text(_clubObject.clubContext!)] : [])
              )
            )
          ],
        )
      ),
    );
  }
}