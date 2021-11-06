import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/clubView/clubDetailView/clubDetailBoard/clubBoardAddView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import 'clubDetailAppBar.dart';
import 'clubDetailTabBar.dart';

class ClubDetailView extends StatefulWidget {
  final String id;
  final initIndex;
  ClubDetailView({required this.id, this.initIndex=0});

  @override
  State<ClubDetailView> createState() => _ClubDetailView(id, initIndex);
}
class _ClubDetailView extends State<ClubDetailView> with SingleTickerProviderStateMixin {
  String _id;
  int initIndex;
  _ClubDetailView(this._id, this.initIndex);
  dynamic result;
  bool _isMember=false;

  late TabController _clubDetailTabController;
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _clubDetailTabController = TabController(length: 4, vsync: this, initialIndex: initIndex);
    if(_clubDetailTabController.index != 0) _isScrolled = true;
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
    if(_clubDetailTabController.indexIsChanging) setState(() {
      _scrollController.jumpTo(0);
      _clubDetailTabController.index != 0 ? _isScrolled = true : _isScrolled = false;
    });
  }

  scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if((_clubDetailTabController.index == 0 && _scrollPosition >= 180) || (_clubDetailTabController.index != 0)) {
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
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _isScrolled ? SizedBox(height: 38) : Container(),
                _clubDetailTabController.index == 0 ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: Image.network(httpsToHttp(result['imageUrls'][0]))
                ) : Container(),
                !_isScrolled ? ClubDetailTabBar(controller: _clubDetailTabController, isMember: _isMember) : Container(),
                clubDetailTabBarView(controller: _clubDetailTabController, result: result)
              ]
            )
          ),
          _isScrolled ? Positioned(
            child: ClubDetailTabBar(controller: _clubDetailTabController, isMember: _isMember)
          ) : Container(),
        ]
      ) : Container(),
      floatingActionButton: _clubDetailTabController.index == 1 ? Container(
        width: 48, height: 48,
        child: FloatingActionButton(
          onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ClubBoardAddView(result)))},
          backgroundColor: Color(0xff0958c5),
          child: SvgPicture.asset('asset/image/icoPlus.svg', width: 20, height: 20),
        )
      ) : null,
    );
  }
}