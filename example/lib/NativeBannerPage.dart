import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/Constant.dart';

class NativeBannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Banner'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                requestNativeBanner();
              },
              child: Text('Request'),
            ),
            RaisedButton(
              onPressed: () {
                showNativeBanner();
              },
              child: Text('Show'),
            ),
          ],
        ),
      )),
    );
  }

  void requestNativeBanner() {
    TapsellPlus.requestNativeBanner(
        Constant.TAPSELL_NATIVE_BANNER,
        (nativeBanner) => nativeBannerResponse(nativeBanner),
        (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  void showNativeBanner() {
    TapsellPlus.showAd(Constant.TAPSELL_NATIVE_BANNER,
        opened: (zoneId) => opened(zoneId),
        closed: (zoneId) => closed(zoneId),
        error: (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  nativeBannerResponse(nativeBanner) {
    print("success: ad_id = ${nativeBanner.adId}");
  }

  error(zoneId, errorMessage) {
    print('error caught: zone_id = $zoneId, message = $errorMessage');
  }

  opened(zoneId) {
    print("opened: zone_id = $zoneId");
  }

  closed(zoneId) {
    print("closed: zone_id = $zoneId");
  }
}
