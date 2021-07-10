import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NavItemView3 extends StatefulWidget {
  @override
  State<NavItemView3> createState() => _NavItemView3();
}

class _NavItemView3 extends State<NavItemView3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Swiper(
                  autoplay: true,
                  // autoplayDelay: 1,
                  // control: SwiperControl(), // 좌우 넘기는 화살표 버튼 유무
                  viewportFraction: 0.8, // 현재 swipe 좌우로 전/후 이미지 일부도 보임
                  scale: 0.8, // 좌우의 전후 이미지 크기 축소
                  pagination: SwiperPagination( // 하단의 swipe 위치 나타내는 점
                    alignment: Alignment.bottomRight
                  ),
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(imgList[index]);
                  },
                )
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2 - 200,
              child: Center(
                child: Text('swiper')
              )
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text('A')
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text('B')
                  )
                )
              ],
            )
          ]
      ),
    );
  }
}

final List<String> imgList = [
  'asset/image/sample.jpeg',
  'asset/image/sample2.jpeg',
];