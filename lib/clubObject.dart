import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'infoView.dart';

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
    return Container(
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
    );
  }

  void _loadClubView(int _inputClubId) {
    String _temp = _inputClubId.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView(_temp)));
  }
}