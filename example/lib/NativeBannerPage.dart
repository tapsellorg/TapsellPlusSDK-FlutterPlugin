import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus_example/Constant.dart';

class NativeBannerPage extends StatelessWidget {
  String adImage, adTitle;

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
              child: Text('Request And Show'),
            ),
            Container(
              child: Image.network("",
                  width: 100.0, height: 100.0, fit: BoxFit.cover),
              margin: EdgeInsets.only(top: 10.0),
              alignment: Alignment(0.0, 0.0),
            ),
            new Container(
              child: new Text(""),
              alignment: Alignment(-1.0, 0.0),
              margin: EdgeInsets.only(top: 10.0, left: 10.0),
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

  nativeBannerResponse(nativeBanner) {
    print("success: ad_id = ${nativeBanner.adId}");
    adImage = nativeBanner.landscapeStaticImageUrl;
    adTitle = nativeBanner.title;
  }

  error(zoneId, errorMessage) {
    print('error caught: zone_id = $zoneId, message = $errorMessage');
  }
}
