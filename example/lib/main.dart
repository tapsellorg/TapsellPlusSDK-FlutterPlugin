import 'package:flutter/material.dart';
import 'package:tapsell_plus/TapsellPlusNativeBanner.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/TapsellRaisedButtonWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    TapsellPlus.setDebugMode(TapsellPlus.DEBUG);
    TapsellPlus.initialize(
        "alsoatsrtrotpqacegkehkaiieckldhrgsbspqtgqnbrrfccrtbdomgjtahflchkqtqosa");
    //TapsellPlus.addFacebookTestDevice("HASH_CODE");

    /*TapsellPlus.requestInterstitial(
        "5cfaa942e8d17f0001ffb292",
        (zoneId) => response(zoneId),
        (zoneId, errorMessage) => error(zoneId, errorMessage));*/

    /*TapsellPlus.requestRewardedVideo(
        "5cfaa802e8d17f0001ffb28e",
        (zoneId) => response(zoneId),
        (zoneId, errorMessage) => error(zoneId, errorMessage));*/

    /*TapsellPlus.requestNativeBanner(
        "5cfaa9deaede570001d5553a",
        (nativeBanner) => nativeBannerResponse(nativeBanner),
        (zoneId, errorMessage) => error(zoneId, errorMessage));*/

    /*TapsellPlus.showAd("5cfaa942e8d17f0001ffb292", (zoneId) => response(zoneId),
        (zoneId, errorMessage) => error(zoneId, errorMessage));*/

    //TapsellPlus.nativeBannerAdClicked("5cfaa802e8d17f0001ffb28e", "");
  }

  response(zoneId) {
    print("success: zone_id = $zoneId");
  }

  error(zoneId, errorMessage) {
    print('error caught: zone_id = $zoneId, message = $errorMessage');
  }

  nativeBannerResponse(nativeBanner) {
    TapsellPlusNativeBanner banner = nativeBanner;

    print("success: native banner Ad id = ${banner.adId}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tapsell plus Plugin'),
        ),
        body: TapsellRaisedButtonWidget(),
      ),
    );
  }
}
