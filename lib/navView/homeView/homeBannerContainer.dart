import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter_source/functionCollection.dart';

class MainBannerContainer extends StatefulWidget {
  @override
  State<MainBannerContainer> createState() => _MainBannerContainer();
}
class _MainBannerContainer extends State<MainBannerContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Swiper(
          autoplay: true,
          control: SwiperControl(),
          itemCount: _bannerItemList.length,
          itemBuilder: (BuildContext context, int index) {
            return BannerItemBuilder(_bannerItemList[index]);
          },
        )
      )
    );
  }
}

final List<String> _tempSrcList = [
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView1.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView2.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView3.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView4.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView5.png',
  'https://raw.githubusercontent.com/LiiNen/indilist_private/master/image/pageView6.png'
];
class BannerItem {
  final String imgSrc;
  final String launchSrc;
  BannerItem({required this.imgSrc, required this.launchSrc});
}

final List<BannerItem> _bannerItemList = List<BannerItem>.generate(_tempSrcList.length, (index) {
  return BannerItem(
    imgSrc: _tempSrcList[index],
    launchSrc: _tempSrcList[index]
  );
});

class BannerItemBuilder extends StatelessWidget {
  BannerItemBuilder(this._bannerItem);
  final BannerItem _bannerItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {launchURL(_bannerItem.launchSrc)},
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_bannerItem.imgSrc),
              fit: BoxFit.cover
            )
          ),
        )
      )
    );
  }
}