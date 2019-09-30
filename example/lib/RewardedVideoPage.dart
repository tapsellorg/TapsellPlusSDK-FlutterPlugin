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
          child:Padding(
            padding: EdgeInsets.all(8.0),
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
          )
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
    TapsellPlus.showAd(Constant.TAPSELL_REWARDED_VIDEO,
        opened: (zoneId) => opened(zoneId),
        closed: (zoneId) => closed(zoneId),
        rewarded: (zoneId) => rewarded(zoneId),
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

  rewarded(zoneId) {
    print("rewarded: zone_id = $zoneId");
  }
}
