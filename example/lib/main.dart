import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() {
  runApp(MyApp());
  TapsellPlus.instance.initialize(TapsellConstant.app_id);
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<Map<String, String>> _list = [];
  String responseId = '';
  String adNetwork = 'tapsell';
  Map<String, String> zoneIds = TapsellConstant.zoneIds['tapsell']!;


  void clearLogs() => setState(() => _list.clear());

  void log(String message, {String? tag}) => setState(() {
        _list.add({
          'tag': tag ?? 'Command',
          'message': message,
          'date': DateTime.now().toIso8601String()
        });
      });

  void setResponseId(String id) => setState(() {
        responseId = id;
      });

  void updateZoneIds(int index) {
    final key = networks[index];
    if (key != null && TapsellConstant.zoneIds.containsKey(key)) {
      setState(() {
        zoneIds = TapsellConstant.zoneIds[key]!;
        adNetwork = key;
      });
    } else {
      log('Selected index is not supported', tag: '--revise');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('TapsellPlus - 2.0.0-nullsafety.0'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: PageView(
                children: networks.values
                    .map((e) => Center(child: Text("<  $e  >", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 16))))
                    .toList(),
                onPageChanged: (index) => updateZoneIds(index),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.teal,
                child: ListView(
                  children: getActions().map((e) {
                    return ListTile(
                      title: Text('${e['ready'] ? '✔' : '❌'} ${e['name']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(e['desc'],
                          style: TextStyle(color: Colors.white60)),
                      onTap: e['onClick'],
                    );
                  }).toList(),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.blueAccent,
            ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: ListView(
                        reverse: true,
                        children: _list
                            .map((e) {
                              final smallTextStyle =
                                  TextStyle(fontSize: 14, color: Colors.white);
                              return ListTile(
                                title: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '~ > tapsellplus -e ${e['tag']}\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.green),
                                    ),
                                    TextSpan(
                                        text: e['message'].toString(),
                                        style: smallTextStyle),
                                  ]),
                                ),
                                subtitle: Text(e['date'].toString(),
                                    style: smallTextStyle.copyWith(
                                        fontSize: 12, color: Colors.white60)),
                              );
                            })
                            .toList()
                            .reversed
                            .toList(),
                      ),
                    ),
                    Positioned(
                        child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.red),
                            onPressed: clearLogs),
                        right: 1.0,
                        top: 1.0)
                  ],
                ))
          ],
        )),
      ),
    );
  }

  Map<int, String> networks = {
    0: "tapsell",
    1: "google",
    2: "chartboost",
    3: "adcolony",
    4: "applovin",
    5: "unityads",
  };

  List<Map<String, dynamic>> getActions() => [
        {
          'name': 'Initialize',
          'desc': 'Initializes the SDK',
          'ready': true,
          'onClick': () {
            String appId = TapsellConstant.app_id;
            TapsellPlus.instance.initialize(appId);
            log('Calling "initialize" with appId = $appId',
                tag: '--initialize');
          }
        },
        {
          'name': 'SetDebugMode',
          'desc': 'Sets debug mode. Daaa!',
          'ready': true,
          'onClick': () {
            TapsellPlus.instance.setDebugMode(3);
            log('Applying debug mode', tag: '--verbose');
          }
        },
        {
          'name': 'Request Interstitial Ad',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            String zoneId = zoneIds["INTERSTITIAL"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support Interstitial", tag: '-i -n $adNetwork');
              return;
            }
            log('Requesting for interstitial ad - ZoneId: $zoneId',
                tag: '--interstitial -n $adNetwork');
            TapsellPlus.instance.requestInterstitialAd(zoneId).then((value) {
              setResponseId(value);
              log('Interstitial Ad "READY"\n responseId: $value',
                  tag: '--interstitial -s');
            }).catchError((error) {
              // Error occurred
            });
          }
        },
        {
          'name': 'Show Interstitial Ad',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showInterstitialAd(id,
                  onOpened: (map) => log('Interstitial ad opened - Data: $map',
                      tag: '--interstitial-show'),
                  onError: (map) => log('Failed to show interstitial ad - $map',
                      tag: '--interstitial-show'));
              log('Showing interstitial ad', tag: '--interstitial-show');
            }
          }
        },
        {
          'name': 'Request rewarded ad',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            String zoneId = zoneIds["REWARDED"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support RewardedAd");
              return;
            }
            log('Requesting for Rewarded. ZoneId: $zoneId',
                tag: '--rewarded-request -n $adNetwork');
            TapsellPlus.instance.requestRewardedVideoAd(zoneId).then((value) {
              log('Rewarded "READY"', tag: '--rewarded -n $adNetwork');
              setResponseId(value);
            });
          }
        },
        {
          'name': 'Show rewarded video ad',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showRewardedVideoAd(id, onOpened: (map) {
                log('Ad opened - Data: $map', tag: '--rewarded-show');
              }, onError: (map) {
                log('Ad error - Error: $map', tag: '--rewarded-show');
              });
            }
          }
        },
        {
          'name': 'Request Standard banner',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            String zoneId = zoneIds["STANDARD"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support StandardBanner");
              return;
            }
            TapsellPlus.instance.requestStandardBannerAd(zoneId, TapsellPlusBannerType.BANNER_320x100).then((value) {
              log('Standard Ad is "READY"', tag: '--standard');
              setResponseId(value);
            });
          }
        },
        {
          'name': 'Show Standard banner',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showStandardBannerAd(id, TapsellPlusHorizontalGravity.TOP, TapsellPlusVerticalGravity.RIGHT, onOpened: (map) {
                log('Ad opened - Data: $map', tag: '--standard-show');
              }, onError: (map) {
                log('Ad error - Error: $map', tag: '--standard-show');
              });
            }
          }
        },
        {
          'name': 'Display Standard banner',
          'desc': 'Displays the banner (if hidden)',
          'ready': true,
          'onClick': () {
            TapsellPlus.instance.displayStandardBanner();
          }
        },
        {
          'name': 'Hide Standard banner',
          'desc': 'Note: This only changes visibility',
          'ready': true,
          'onClick': () {
            TapsellPlus.instance.hideStandardBanner();
          }
        },
        {
          'name': 'Destroy Standard banner',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            final resId = responseId;
            if(resId.isEmpty) {
              log('Can not destroy while there is no responseId', tag: '--standard-destroy');
              return;
            }
            TapsellPlus.instance.destroyStandardBanner(resId);
          }
        },

        {
          'name': 'Request Native banner',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            String zoneId = zoneIds["NATIVE"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support NativeAd");
              return;
            }
            TapsellPlus.instance.requestNativeAd(zoneId).then((value) {
              log('Standard Ad is "READY"', tag: '--native');
              setResponseId(value);
            }).catchError((error) {
              log('Error requesting ad - $error', tag: '--native-status');
            });
          }
        },
        {
          'name': 'Show Native banner',
          'desc': 'Title is obvious',
          'ready': true,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showNativeAd(id, onOpened: (map) {
                log('Ad opened - Data: $map', tag: '--native-show');
              }, onError: (map) {
                log('Ad error - Error: $map', tag: '--native-show');
              });
            }
          }
        },
      ];
}

class TapsellConstant {
  static const app_id = 'alsoatsrtrotpqacegkehkaiieckldhrgsbspqtgqnbrrfccrtbdomgjtahflchkqtqosa';
  static const interstitial_zone = '5cfaa942e8d17f0001ffb292';
  static const rewarded_video_zone = '5cfaa802e8d17f0001ffb28e';
  static const native_banner_zone = '5cfaa9deaede570001d5553a';
  static const standard_zone = '5cfaaa30e8d17f0001ffb294';

  static const zoneIds = {
    "tapsell": {
      "REWARDED": '5cfaa802e8d17f0001ffb28e',
      "INTERSTITIAL": '5cfaa942e8d17f0001ffb292',
      "NATIVE": '5cfaa9deaede570001d5553a',
      "STANDARD": '5cfaaa30e8d17f0001ffb294',
    },
    "google": {
      "REWARDED": '5cfaa8aee8d17f0001ffb28f',
      "INTERSTITIAL": '5cfaa9b0e8d17f0001ffb293',
      "NATIVE": '5d123c9968287d00019e1a94',
      "STANDARD": '5cfaaa4ae8d17f0001ffb295',
    },
    "adcolony": {
      "REWARDED": '5d3362766de9f600013662d5',
      "INTERSTITIAL": '5d336289e985d50001427acf'
    },
    "applovin": {
      "REWARDED": '5d3eb48c3aef7a0001406f84',
      "INTERSTITIAL": '5d3eb4fa3aef7a0001406f85',
      "STANDARD": '5d3eb5337a9b060001892441',
    },
    "chartboost": {
      "REWARDED": '5cfaa8cee8d17f0001ffb290'
    },
    "unityads": {
      "REWARDED": '5cfaa8eae8d17f0001ffb291',
      "INTERSTITIAL": '608d1c1c2d8e7e0001348111',
      "STANDARD": '608d20a7fb661b000190bfe4',
    }
  };
}
