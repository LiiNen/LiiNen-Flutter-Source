import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'clubCreationView/clubCreationView.dart';
import 'homeBannerContainer.dart';
import 'clubSuggestionContainer.dart';
import 'feedSuggestionContainer.dart';

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
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(home: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            MainBannerContainer(),
            SizedBox(height: 20 * responsiveScale),
            ClubSuggestionContainer(),
            SizedBox(height: 16 * responsiveScale),
            FeedSuggestionContainer(),
          ],
          controller: _scrollController
        ),
      ),
      floatingActionButton: Container(
        width: 48, height: 48,
        child: FloatingActionButton(
          onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ClubCreationView()))},
          backgroundColor: Color(0xff0958c5),
          child: SvgPicture.asset('asset/image/icoPlus.svg', width: 20, height: 20),
        )
      ),
    );
  }
}