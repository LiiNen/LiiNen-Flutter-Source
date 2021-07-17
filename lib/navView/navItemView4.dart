import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../searchView.dart';
import '../infoView.dart';

class NavItemView4 extends StatefulWidget {
  @override
  State<NavItemView4> createState() => _NavItemView4();
}

class _NavItemView4 extends State<NavItemView4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: PersonalAppBar(),
      body: Column(
        children: [
          PersonalComponent(),
          Container(
            height: heightSize,
            width: MediaQuery.of(context).size.width,
            child: Image.network(mybanner, fit: BoxFit.fill)
          )
        ]
      )
    );
  }
}

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawer();
}
class _NavDrawer extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          DrawerHeader(
            child: Text('side menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(mybanner)
              )
            )
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('list 1'),
            onTap: () => _loadList1View('test'),
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('list 2'),
            onTap: () => {},
          )
        ]
      )
    );
  }
  void _loadList1View(String _infoSrc) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoView(_infoSrc)));
  }
}

class PersonalAppBar extends StatefulWidget implements PreferredSizeWidget{
  PersonalAppBar() : preferredSize = Size.fromHeight(kToolbarHeight);
  @override
  final Size preferredSize;

  @override
  State<PersonalAppBar> createState() => _PersonalAppBar();
}
class _PersonalAppBar extends State<PersonalAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('개인 설정'),
      leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: _loadSearchView
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: Scaffold.of(context).openEndDrawer,
        ),
      ]
    );
  }

  void _loadSearchView() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
  }
}

class PersonalComponent extends StatefulWidget{
  @override
  State<PersonalComponent> createState() => _PersonalComponent();
}
class _PersonalComponent extends State<PersonalComponent> {
  var _profileImage;
  @override
  initState() {
    super.initState();
    _loadProfile();
  }
  _loadProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final _image = pref.get("profile") ?? null;
    setState(() {
      if(_image != null) {
        _profileImage = _image;
      }
      else {
        _profileImage = NetworkImage('mypict');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: widthSize,
            height: heightSize,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(mypict),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(widthSize/2))
                          ),
                        ),
                        IconButton(onPressed: _modifyImage, icon: Icon(Icons.add))
                      ]
                  ),
                )
            )
        ),
        Container(
            width: MediaQuery.of(context).size.width - widthSize,
            height: heightSize,
            child: Column(
              children: [
                Container(
                    height: heightSize / 3,
                    child: Center(
                        child: Text('myName')
                    )
                ),
                Container(
                    child: Row(
                      children: [
                        Container(
                            width: (MediaQuery.of(context).size.width - widthSize) / 2,
                            height: heightSize / 3,
                            child: Center(
                                child: Text('left')
                            )
                        ),
                        Container(
                            width: (MediaQuery.of(context).size.width - widthSize) / 2,
                            height: heightSize / 3,
                            child: Center(
                                child: Text('right')
                            )
                        )
                      ],
                    )
                ),
                Container(
                    height: heightSize / 3,
                    child: Image.asset('asset/image/sample2.jpeg')
                )
              ],
            )
        )
      ],
    );
  }

  void _modifyImage() async{
    final ImagePicker _imagePicker = ImagePicker();
    try {
      final _pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);

    } catch(e) {
      print(e);
      setState(() {

      });
    }
  }
}

final String mypict = 'https://liinen.github.io/Team7-Blog/images/jeonghoon/jeonghoon_picture.png';
final String mybanner = 'https://liinen.github.io/Team7-Blog/images/home/home_banner.png';
final double widthSize = 150;
final double heightSize = 150;
