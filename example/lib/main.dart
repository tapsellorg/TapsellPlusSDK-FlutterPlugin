import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/TapsellPlusResponse.dart';
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

    TapsellPlus.requestInterstitial("5cfaa942e8d17f0001ffb292").then((value) {
      TapsellPlus.showAd(value).then((value) {
        Map responseMap = jsonDecode(value);
        var response = TapsellPlusResponse.fromJson(responseMap);

        print("success: zone_id = ${response.zoneId}");
        print("success: responce_type = ${response.responseType}");
      }).catchError((err) {
        print('error caught: zone_id = ${err.code}, message = ${err.message}');
      });
    }).catchError((err) {
      print('error caught: zone_id = ${err.code}, message = ${err.message}');
    });

    /*TapsellPlus.requestRewardedVideo("5cfaa802e8d17f0001ffb28e").then((value) {
      print("success: zone_id = $value");
    }).catchError((err) {
      print('error caught: zone_id = ${err.code}, message = ${err.message}');
    });*/

    /*TapsellPlus.requestNativeBanner("5cfaa9deaede570001d5553a").then((value) {
      Map nativeBannerMap = jsonDecode(value);
      var nativeBanner = TapsellPlusNativeBanner.fromJson(nativeBannerMap);

      print("success: native banner = $value");
      print("success: native banner Ad id = ${nativeBanner.adId}");

    }).catchError((err) {
      print('error caught: zone_id = ${err.code}, message = ${err.message}');
    });*/

    /*TapsellPlus.showAd("5cfaa942e8d17f0001ffb292").then((value) {
      print("success: zone_id = $value");
    }).catchError((err) {
      print('error caught: zone_id = ${err.code}, message = ${err.message}');
    });*/

    TapsellPlus.nativeBannerAdClicked("5cfaa802e8d17f0001ffb28e", "");
  }

  /*// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await TapsellPlus.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }*/

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
