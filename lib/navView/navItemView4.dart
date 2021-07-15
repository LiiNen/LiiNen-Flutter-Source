import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NavItemView4 extends StatefulWidget {
  @override
  State<NavItemView4> createState() => _NavItemView4();
}

class _NavItemView4 extends State<NavItemView4> {
  var _profileImage = NetworkImage(mypict);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개인 설정'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}
          )
        ],
      ),
      body: Column(
        children: [
          Row(
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
                              image: _profileImage,
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
          ),
          Container(
            height: heightSize,
            width: MediaQuery.of(context).size.width,
            child: Image.network(mybanner, fit: BoxFit.fill)
          )
        ]
      )
    );
  }

  Future<void> _modifyImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image as NetworkImage;
    });
  }
}

final String mypict = 'https://liinen.github.io/Team7-Blog/images/jeonghoon/jeonghoon_picture.png';
final String mybanner = 'https://liinen.github.io/Team7-Blog/images/home/home_banner.png';
final double widthSize = 150;
final double heightSize = 150;
