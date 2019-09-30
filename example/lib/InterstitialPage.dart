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
        child:Padding(
          padding: EdgeInsets.all(8.0),
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
        )
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
    TapsellPlus.showAd(Constant.TAPSELL_INTERSTITIAL,
        opened: (zoneId) => opened(zoneId),
        closed: (zoneId) => closed(zoneId),
        error: (zoneId, errorMessage) => error(zoneId, errorMessage));
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
}
