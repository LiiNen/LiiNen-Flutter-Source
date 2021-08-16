import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'infoView.dart';
import 'containerCollection.dart';

class ClubObject {
  final int clubId;
  final String clubName;
  final String clubImgSrc;
  final String clubContext;
  final String clubGenre;
  ClubObject({required this.clubId, required this.clubName, this.clubImgSrc = '', required this.clubContext, required this.clubGenre});
}

List<String> clubImgSrcList = [
  'asset/category/boardGame.jpeg',
  'asset/category/etc.jpeg',
  'asset/category/it.jpeg',
  'asset/category/diy.jpeg',
  'asset/category/reading.jpeg',
  'asset/category/sport.jpeg'
];
List<String> clubNameList = ['보드게임모임', '집모임', '코딩동아리', '직접제작동아리'];
List<String> clubGenreList = ['보드게임', 'etc', 'IT', 'diy'];
List<ClubObject> clubObjectList = List<ClubObject>.generate(clubNameList.length, (index) {
  return ClubObject(clubId: index, clubName: clubNameList[index], clubImgSrc: clubImgSrcList[index], clubContext: '설명설명', clubGenre: clubGenreList[index]);
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
                    child: Text(_inputClubObject.clubName, style: textStyle(weight: 700, size: 20.0))
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
  final ScrollController scrollController;
  FeedListContainer({required this.feedTitle, required this.scrollController});

  @override
  State<FeedListContainer> createState() => _FeedListContainer(feedTitle: feedTitle, scrollController: scrollController);
}
class _FeedListContainer extends State<FeedListContainer> {
  final String feedTitle;
  final ScrollController scrollController;
  _FeedListContainer({required this.feedTitle, required this.scrollController});

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
            children: List<Widget>.generate(feedCount + 1, (index) {
              return (index == feedCount ? CircularProgressIndicator() : FeedObjectItem(index));
            })
          )
        )
      ]
    );
  }

  void scrollEnd() {
    if(this.mounted) setState((){
      feedCount += 3;
      print(feedCount);
    });
  }
  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if(maxScroll - currentScroll < 0) {
      scrollEnd();
    }
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