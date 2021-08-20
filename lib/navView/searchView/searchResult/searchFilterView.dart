import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';

import 'package:my_flutter_source/functionCollection.dart';

bool isRecruit = false;
List<String> _filterList = ['추천순', '최신순'];
var selectedIndex = -1;

class SearchFilterView extends StatefulWidget {
  @override
  State<SearchFilterView> createState() => _SearchFilterView();
}
class _SearchFilterView extends State<SearchFilterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterAppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TitleContainer('정렬'),
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 21),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8, runSpacing: 8,
                children: _filterList.map((e) => _filterItem(e)).toList(),
              )
            ),
            SizedBox(height: 32),
            TitleContainer('선택'),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {setState(() {
                isRecruit = !isRecruit;
              });},
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isRecruit
                      ? SvgPicture.asset('asset/image/checkBoxUncheck.svg', width: 24, height: 24)
                      : SvgPicture.asset('asset/image/checkBoxCheck.svg', width: 24, height: 24),
                    SizedBox(width: 8),
                    Text('모집 중인 모임만 보기', style: textStyle(weight: 400, size: 14.0), textAlign: TextAlign.left,)
                  ],
                )
              )
            )
          ],
        )
      )
    );
  }

  void _filterUpdate(inputIndex) {
    if(selectedIndex == inputIndex) {
      selectedIndex = -1;
    } else {
      selectedIndex = inputIndex;
    }
  }
  GestureDetector _filterItem(title) {
    var index = _filterList.indexOf(title);
    var _selected = (index == selectedIndex);
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterUpdate(index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: _selected ? Color(0xff0958c5) : Color(0xffd3d7df), width: 1),
          color: _selected ? Color(0xff0958c5) : Color(0xffffffff),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
          child: Text(title, style: textStyle(color: _selected ? Color(0xffffffff) : Color(0xffd1d5d9), weight: 400, size: 14.0),)
        )
      )
    );
  }
}

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  FilterAppBar() : preferredSize = Size.fromHeight(40.0);
  @override
  final Size preferredSize;

  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,

      title: Text('필터', style: textStyle(weight: 700, size: 16.0),),
      flexibleSpace: Stack(children: [
        Positioned(
          bottom: 8, left: 21,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
          ),
        ),
        Positioned(
          bottom: 12, right: 21,
          child: GestureDetector(
            // onTap: () => {_filterInit()}, // TODO : call other class func
            child: Text('초기화', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0),)
          )
        )
      ]),
    );
  }
}