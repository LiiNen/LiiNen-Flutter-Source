import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/clubObject.dart';

import '../../main.dart';
import 'homeBannerContainer.dart';
import 'clubSuggestionContainer.dart';

import '../../infoView.dart';
import '../../containerCollection.dart';

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
            TitleContainer('오늘의 번개'),
            ClubSuggestionContainer(),
            SizedBox(height: 48 * responsiveScale),
            TitleContainer('추천모임'),
            ClubSuggestionContainer(),
            SizedBox(height: 48 * responsiveScale),
            FeedListContainer(feedTitle: '최근 활동 중인 피드', scrollController: _scrollController)
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

class MiddleContainer extends StatefulWidget {
  @override
  State<MiddleContainer> createState() => _MiddleContainer();
}
class _MiddleContainer extends State<MiddleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          color: Colors.green,
          child: Center(
            child: Text('middlew')
          )
        )
      ),
    );
  }
}

final List<String> horList = List<String>.generate(20, (index) => 'hello $index');
final List<Widget> vertItemsList = List<Widget>.generate(horList.length, (index) {
  return Column(
    children: [
      Container(
        height: 100,
        color: Colors.lightBlue,
        child: Center(
          child: Text(horList[index])
        )
      ),
      Container(
        height: 10,
        color: Colors.white,
      )
    ],
  );
});

class HorizontalContainer extends StatefulWidget {
  @override
  State<HorizontalContainer> createState() => _HorizontalContainer();
}
class _HorizontalContainer extends State<HorizontalContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: horList.length,
        itemBuilder: (BuildContext context, int index) {
          return HorizontalItem(horList[index], Colors.orange);
        },
      )
    );
  }
}

class HorizontalItem extends StatefulWidget {
  HorizontalItem(this._text, this._color);
  final String _text;
  final Color _color;
  @override
  State<HorizontalItem> createState() => _HorizontalItem(_text, _color);
}
class _HorizontalItem extends State<HorizontalItem> {
  _HorizontalItem(this._text, this._color);
  String _text;
  final Color _color;
  void _loadInfoView() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView(_text)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: _color
            ),
            child: Center(
             child: Text(_text)
            ),
          ),
          onTap: () => _loadInfoView(),
        )
      )
    );
  }
}
