import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/clubObject.dart';

import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'homeBannerContainer.dart';
import 'clubSuggestionContainer.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final _scrollController = ScrollController();

  Color inC = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(home: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            MainBannerContainer(),
            SizedBox(height: 20 * responsiveScale),
            ClubSuggestionContainer(),
            SizedBox(height: 48 * responsiveScale),
            TitleContainer('추천모임'),
            ClubSuggestionContainer(),
          ],
          controller: _scrollController
        ),
      ),
      floatingActionButton: Container(
        width: 48, height: 48,
        child: FloatingActionButton(
          onPressed: () => {},
          backgroundColor: Color(0xff0958c5),
          child: SvgPicture.asset('asset/image/icoPlus.svg', width: 20, height: 20),
        )
      ),
    );
  }
}