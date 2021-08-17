import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

class SearchTextView extends StatefulWidget {
  @override
  State<SearchTextView> createState() => _SearchTextView();
}
class _SearchTextView extends State<SearchTextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainViewAppBar(title: '탐색', back: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: GestureDetector(
          onTap: () => {},
          child: Column(
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 16 * responsiveScale),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Color(0xfff5f5f5),
                  ),
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 14, bottom: (40 * responsiveScale - 15) / 2), // TODO : 왜 30인지 모르겠음
                      hintText: '어떤 모임을 찾으시나요?',
                      hintStyle: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0),
                    ),
                    style: textStyle(weight: 400, size: 12.0),
                  )
                )
              )
            ],
          )
        )
      )
    );
  }
}