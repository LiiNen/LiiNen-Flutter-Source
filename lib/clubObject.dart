import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'infoView.dart';
import 'containerCollection.dart';

class ClubObject {
  final int clubId;
  final String clubName;
  ClubObject(this.clubId, this.clubName);
}
List<String> clubList = ['기타모임', '친목모임', '무슨모임', '이건모임'];
List<ClubObject> clubObjectList = List<ClubObject>.generate(clubList.length, (index) {
  return ClubObject(index, clubList[index]);
});

class ClubObjectItem extends StatefulWidget {
  ClubObjectItem(this._inputClubObject);
  final ClubObject _inputClubObject;
  @override
  State<ClubObjectItem> createState() => _ClubObjectItem(_inputClubObject);
}
class _ClubObjectItem extends State<ClubObjectItem> {
  _ClubObjectItem(this._inputClubObject);
  final ClubObject _inputClubObject;

  double _size = 100;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _size,
          height: _size,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(_size/2)),
                    border: Border.all()
                ),
                child: Center(
                    child: Text(_inputClubObject.clubName)
                )
              ),
              onTap: () => _loadClubView(_inputClubObject.clubId)
            )
          )
        ),
        Container(
          width: _size,
          height: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: Text(_inputClubObject.clubName))
          )
        )
      ]
    );
  }

  void _loadClubView(int _inputClubId) {
    String _temp = _inputClubId.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView(_temp)));
  }
}

class FeedListContainer extends StatefulWidget {
  final String feedTitle;
  FeedListContainer({required this.feedTitle});

  @override
  State<FeedListContainer> createState() => _FeedListContainer(feedTitle: feedTitle);
  void scrollEnd() {
    _FeedListContainer(feedTitle: feedTitle).scrollEnd();
  }
}
class _FeedListContainer extends State<FeedListContainer> {
  final String feedTitle;
  _FeedListContainer({required this.feedTitle});

  int feedCount = 7;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TitleContainer(feedTitle),
          Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: List<FeedObjectItem>.generate(feedCount, (index) {
                  return FeedObjectItem(index);
                })
              )
          )
        ]
    );
  }

  void scrollEnd() {
    feedCount += 3;
    print(feedCount);
  }
}

class FeedObjectItem extends StatefulWidget {
  final int _testIndex;
  FeedObjectItem(this._testIndex);
  @override
  State<FeedObjectItem> createState() => _FeedObjectItem(_testIndex);
}
class _FeedObjectItem extends State<FeedObjectItem> {
  int _testIndex;
  _FeedObjectItem(this._testIndex);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Row(
            children: [
              FlutterLogo(size: 40),
              Flexible(
                child: Column(children: [
                  Text(_testIndex.toString()),
                  Text(
                    '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )
                ])
              )
            ]
          )
        ),
        onTap: () => {},
      )
    );
  }
}