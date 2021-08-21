import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'adMobHelper.dart';

class AdMobBanner extends StatefulWidget {
  @override
  State<AdMobBanner> createState() => _AdMobBanner();
}
class _AdMobBanner extends State<AdMobBanner> {
  static final _kAdIndex = 2;
  late BannerAd _ad;
  bool _isAdLoaded = false;
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) return rawIndex - 1;
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: _ad),
      width: _ad.size.width.toDouble(),
      height: 72,
      alignment: Alignment.center,
    );
  }
}