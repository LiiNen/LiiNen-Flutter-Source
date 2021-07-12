import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class NavItemView2 extends StatefulWidget {
  @override
  State<NavItemView2> createState() => _NavItemView2();
}

class _NavItemView2 extends State<NavItemView2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          BannerContainer(),
        ],
      ),
    );
  }
}

class BannerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Swiper(
        autoplay: true,
        control: SwiperControl(),
        itemCount: _imgSrcList.length,
        itemBuilder: (BuildContext context, int index) {
          return BannerItem(_imgSrcList[index]);
        },
      )
    );
  }
}

class BannerItem extends StatelessWidget {
  BannerItem(this._imgSrc);
  final String _imgSrc;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _launchURL(_imgSrc),
        child: Image.network(_imgSrc)
      )
    );
  }
}

void _launchURL(_srcURL) async => await canLaunch(_srcURL) ? await launch(_srcURL) : throw 'url \"$_srcURL\" error';

final List<String> _imgSrcList = [
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView1.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView2.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView3.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView4.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView5.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView6.png'
];
