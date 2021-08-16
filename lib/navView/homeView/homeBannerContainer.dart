import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_flutter_source/clubObject.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

class MainBannerContainer extends StatefulWidget {
  @override
  State<MainBannerContainer> createState() => _MainBannerContainer();
}
class _MainBannerContainer extends State<MainBannerContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 168 * responsiveScale,
        child: Swiper(
          autoplay: true,
          pagination: swiperPagination(),
          itemCount: _bannerItemList.length,
          itemBuilder: (BuildContext context, int index) {
            return BannerItemBuilder(_bannerItemList[index]);
          },
        )
      )
    );
  }
}

class BannerItem {
  final String imgSrc;
  final String launchSrc;
  BannerItem({required this.imgSrc, required this.launchSrc});
}

final List<BannerItem> _bannerItemList = List<BannerItem>.generate(clubImgSrcList.length, (index) {
  return BannerItem(
    imgSrc: clubImgSrcList[index],
    launchSrc: clubImgSrcList[index]
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
              image: AssetImage(_bannerItem.imgSrc),
              fit: BoxFit.cover
            )
          ),
        )
      )
    );
  }
}