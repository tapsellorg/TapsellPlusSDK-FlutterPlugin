import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/Constant.dart';

class RewardedVideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewarded Video'),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  requestRewardedVideo();
                },
                child: Text('Request'),
              ),
              RaisedButton(
                onPressed: () {
                  showRewardedVideo();
                },
                child: Text('Show'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void requestRewardedVideo() {
    TapsellPlus.requestRewardedVideo(
        Constant.TAPSELL_REWARDED_VIDEO,
        (zoneId) => response(zoneId),
        (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  void showRewardedVideo() {
    TapsellPlus.showAd(
        Constant.TAPSELL_REWARDED_VIDEO,
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
