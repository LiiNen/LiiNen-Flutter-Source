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