import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailBoard/clubBoardAddView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import 'clubDetailAppBar.dart';
import 'clubDetailTabBar.dart';

class ClubDetailView extends StatefulWidget {
  final String _id;
  ClubDetailView(this._id);

  @override
  State<ClubDetailView> createState() => _ClubDetailView(_id);
}
class _ClubDetailView extends State<ClubDetailView> with SingleTickerProviderStateMixin {
  String _id;
  _ClubDetailView(this._id);
  dynamic result;
  bool _isMember=false;

  late TabController _clubDetailTabController;
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _clubDetailTabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _clubDetailTabController.addListener(tabChangeListener);
    _scrollController.addListener(scrollListener);
    _getMeeting();
  }

  @override
  void dispose() {
    _clubDetailTabController.dispose();
    super.dispose();
  }

  tabChangeListener() {
    if(_clubDetailTabController.indexIsChanging) setState(() {});
  }

  scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if((_clubDetailTabController.index == 0 && _scrollPosition >= 180) || (_clubDetailTabController.index != 0 && _scrollPosition >= 0)) {
        _isScrolled = true;
      }
      else {
        _isScrolled = false;
      }
    });
  }

  void _getMeeting() async {
    var _temp = await getMeetingById(_id);
    setState(() {
      result = _temp;
      if(result['persons']['president']['_id'] == userInfo['_id']) {
        _isMember = true;
      }
      else {
        result['persons']['members'].toList().map((e) {
          if (e['_id'] == userInfo['_id']) _isMember = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClubDetailAppBar(
        title: result != null ? result['name'] : '',
        isPresident: result != null ? userInfo['_id'] == result['persons']['president']['_id'] : false,
        result: result
      ),
      body: result != null ? Stack(
        children: [
          _isScrolled ? Positioned(
            child: ClubDetailTabBar(controller: _clubDetailTabController, isMember: _isMember)
          ) : Container(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _clubDetailTabController.index == 0 ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: Image.network(httpsToHttp(result['imageUrls'][0]))
                ) : Container(),
                !_isScrolled ? ClubDetailTabBar(controller: _clubDetailTabController, isMember: _isMember) : Container(),
                clubDetailTabBarView(controller: _clubDetailTabController, result: result)
              ]
            )
          )
        ]
      ) : Container(),
      floatingActionButton: _clubDetailTabController.index == 1 ? Container(
        width: 48, height: 48,
        child: FloatingActionButton(
          onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ClubBoardAddView()))},
          backgroundColor: Color(0xff0958c5),
          child: SvgPicture.asset('asset/image/icoPlus.svg', width: 20, height: 20),
        )
      ) : null,
    );
  }
}