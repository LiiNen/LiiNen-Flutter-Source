import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(NavItemView3());

class NavItemView3 extends StatefulWidget {
  @override
  State<NavItemView3> createState() => _NavItemView3();
}

class _NavItemView3 extends State<NavItemView3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Swiper(
            control: SwiperControl(),
            pagination: SwiperPagination(),
            itemCount: imgList.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(imgList[index]);
            },
          )
        )
      ),
    );
  }
}

final List<String> imgList = [
  'asset/image/sample.jpeg',
  'asset/image/sample2.jpeg',
];