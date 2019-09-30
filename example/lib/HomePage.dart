import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/Constant.dart';
import 'package:tapsell_plus_example/InterstitialPage.dart';
import 'package:tapsell_plus_example/NativeBannerPage.dart';
import 'package:tapsell_plus_example/RewardedVideoPage.dart';
import 'package:tapsell_plus_example/StandardBannerPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initTapsellPlus();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RewardedVideoPage()),
                  );
                },
                child: Text('Rewarded Video'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InterstitialPage()),
                  );
                },
                child: Text('Interstitial'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NativeBannerPage()),
                  );
                },
                child: Text('Native Banner'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StandardBannerPage()),
                  );
                },
                child: Text('Standard Banner'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initTapsellPlus() {
    TapsellPlus.setDebugMode(TapsellPlus.DEBUG);
    TapsellPlus.initialize(Constant.TAPSELL_KEY);
  }
}
