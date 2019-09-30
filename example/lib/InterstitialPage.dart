import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/Constant.dart';

class InterstitialPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interstitial'),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  requestInterstitial();
                },
                child: Text('Request'),
              ),
              RaisedButton(
                onPressed: () {
                  showInterstitial();
                },
                child: Text('Show'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void requestInterstitial() {
    TapsellPlus.requestInterstitial(
        Constant.TAPSELL_INTERSTITIAL,
            (zoneId) => response(zoneId),
            (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  void showInterstitial() {
    TapsellPlus.showAd(
        Constant.TAPSELL_INTERSTITIAL,
            (zoneId) => opened(zoneId),
            (zoneId) => closed(zoneId),
            (zoneId) => rewarded(zoneId),
            (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  response(zoneId) {
    print("success: zone_id = $zoneId");
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

  rewarded(zoneId) {
    print("rewarded: zone_id = $zoneId");
  }
}
