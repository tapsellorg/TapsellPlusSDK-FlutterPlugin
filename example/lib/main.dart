import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tapsell_plus/NativeAdData.dart';
import 'package:tapsell_plus/NativeAdPayload.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'modal.dart';

///
/// **Note**: For detailed example, clone the github sample from
/// [Sample Github repo](https://github.com/tapsellorg/TapsellPlusSDK-FlutterSample)
///
void main() {
  runApp(MaterialApp(home: MyApp()));
  TapsellPlus.instance.initialize(TapsellConstant.app_id);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, String>> _list = [];
  String responseId = '';
  String unitId = '';

  String adNetwork = 'tapsell';
  Map<String, String> zoneIds = TapsellConstant.zoneIds['Tapsell']!;

  // Native Admob
  String factoryId = 'FullNativeAdFactory';
  bool isAdmobNativeLoaded = false;
  NativeAd? admobNativeAd;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  void setUnitId(String id) => setState(() {
        unitId = id;
      });

  void setAdmobNativeLoaded(bool loaded) => setState(() {
        isAdmobNativeLoaded = loaded;
      });

  void setAdmobNativeAd(NativeAd? ad) => setState(() {
        admobNativeAd = ad;
      });

  void updateZoneIds(int index) => setState(() {
        final key = networks[index];
        if (key != null && TapsellConstant.zoneIds.containsKey(key)) {
          zoneIds = TapsellConstant.zoneIds[key]!;
          adNetwork = key;
        } else {
          log('Selected index is not supported', tag: '--revise');
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('TapsellPlus - 2.3.2'),
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
                  .map((e) => Center(
                      child: Text("←  $e  →",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))))
                  .toList(),
              onPageChanged: (index) => updateZoneIds(index),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.blueGrey,
              child: ListView(
                children: getActions().map((e) {
                  return ListTile(
                    title: Text('${e['ready'] ? '🆗' : '⛔'} ${e['name']}',
                        style: TextStyle(
                            color: Colors.white
                                .withOpacity(e['ready'] ? 1.0 : 0.5),
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(e['desc'],
                        style: TextStyle(color: Colors.white60)),
                    onTap: () {
                      if (e['ready'])
                        e['onClick']?.call();
                      else
                        log('Options is not supported for type $adNetwork');
                    },
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
              )),
          isAdmobNativeLoaded
              ? Container(
                  child: AdWidget(ad: admobNativeAd!),
                  width: double.infinity,
                  height: 250,
                  alignment: Alignment.center,
                )
              : Container(),
        ],
      )),
    );
  }

  void showNativeAd(NativeAdData ad) => showDialog(
      context: _scaffoldKey.currentContext ?? context,
      builder: (context) {
        return AlertDialog(
          title: Text("NativeAd"),
          content: NativeAdWidget(
              responseId: ad.responseId ?? '',
              title: ad.title ?? '',
              description: ad.description ?? '',
              callToAction: ad.callToActionText ?? '',
              iconUrl: ad.iconUrl ?? '',
              portraitImageUrl: ad.portraitImageUrl ?? '',
              landScapeImageUrl: ad.landscapeImageUrl ?? '',
              onClick: () => Navigator.of(context).pop()),
        );
      });

  Map<int, String> networks = {
    0: "Tapsell",
    1: "Google AdMob",
    2: "Chart boost",
    3: "AdColony",
    4: "AppLovin",
    5: "Unity Ads",
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
            TapsellPlus.instance.setDebugMode(LogLevel.Verbose);
            log('Applying debug mode', tag: '--verbose');
          }
        },
        {
          'name': 'Set Gdpr consent',
          'desc': 'Sets GDPR to true',
          'ready': true,
          'onClick': () {
            log('Applying GDPR consent', tag: '--gdpr');
            final consent = true;
            TapsellPlus.instance.setGDPRConsent(consent).then((value) {
              log('GDPR consent set to $consent', tag: '--gdpr-status');
            }).catchError((error) {
              log('Failed to apply GDPR', tag: '--gdpr-status');
            });
          }
        },
        {
          'name': 'Request Interstitial Ad',
          'desc': 'Title is obvious',
          'ready': zoneIds["INTERSTITIAL"] != null,
          'onClick': () {
            String zoneId = zoneIds["INTERSTITIAL"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support Interstitial",
                  tag: '-i -n $adNetwork');
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
          'ready': zoneIds["INTERSTITIAL"] != null,
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
          'ready': zoneIds["REWARDED"] != null,
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
          'ready': zoneIds["REWARDED"] != null,
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
          'ready': zoneIds["STANDARD"] != null,
          'onClick': () {
            String zoneId = zoneIds["STANDARD"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support StandardBanner");
              return;
            }
            TapsellPlus.instance.requestStandardBannerAd(
                zoneId, TapsellPlusBannerType.BANNER_320x50, onResponse: (map) {
              log('Standard Ad is "READY"', tag: '--standard');
              setResponseId(map['response_id'] ?? '');
            }, onError: (map) {
              log('Standard Ad error - $map', tag: '--standard-show');
            });
          }
        },
        {
          'name': 'Show Standard banner',
          'desc': 'Title is obvious',
          'ready': zoneIds["STANDARD"] != null,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showStandardBannerAd(
                  id,
                  TapsellPlusHorizontalGravity.TOP,
                  TapsellPlusVerticalGravity.CENTER,
                  margin: EdgeInsets.only(top: 100), onOpened: (map) {
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
          'ready': zoneIds["STANDARD"] != null,
          'onClick': () {
            TapsellPlus.instance.displayStandardBanner();
          }
        },
        {
          'name': 'Hide Standard banner',
          'desc': 'Note: This only changes visibility',
          'ready': zoneIds["STANDARD"] != null,
          'onClick': () {
            TapsellPlus.instance.hideStandardBanner();
          }
        },
        {
          'name': 'Destroy Standard banner',
          'desc': 'Title is obvious',
          'ready': zoneIds["STANDARD"] != null,
          'onClick': () {
            final resId = responseId;
            if (resId.isEmpty) {
              log('Can not destroy while there is no responseId',
                  tag: '--standard-destroy');
              return;
            }
            TapsellPlus.instance.destroyStandardBanner(resId);
          }
        },
        {
          'name': 'Request Native banner',
          'desc': 'Title is obvious',
          'ready': zoneIds["NATIVE"] != null,
          'onClick': () {
            String zoneId = zoneIds["NATIVE"] ?? "";
            if (zoneId.isEmpty) {
              log("AdNetwork '$adNetwork' does not support NativeAd");
              return;
            }
            TapsellPlus.instance.requestNativeAd(zoneId, onResponse: (map) {
              log('Native Ad is "READY"', tag: '--native');
              print('requestNativeAd:' + map.entries.toString());
              setResponseId(map['response_id'] ?? "");
              setUnitId(map['adnetwork_zone_id'] ?? "");
            }, onError: (map) {
              log('Error requesting ad - ${map.entries}',
                  tag: '--native-status');
            });
          }
        },
        {
          'name': 'Show Native banner',
          'desc': 'Title is obvious',
          'ready': zoneIds["NATIVE"] != null,
          'onClick': () {
            final id = responseId;
            if (id.isNotEmpty) {
              TapsellPlus.instance.showNativeAd(id, admobFactoryId: factoryId,
                  onOpened: (nativeAd) {
                if (nativeAd is GeneralNativeAdPayload) {
                  log('Ad opened - Data: ${nativeAd.ad.toMap()}',
                      tag: '--native-show');
                  showNativeAd(nativeAd.ad);
                } else if (nativeAd is AdMobNativeAdPayload) {
                  log('Admob opened - Data: ${nativeAd.ad.responseInfo?.responseId}',
                      tag: '--native-show');
                }
              }, onLoaded: (nativeAd) {
                if (nativeAd is AdMobNativeAdPayload) {
                  setAdmobNativeLoaded(true);
                } else if (nativeAd is AdMobNativeAdViewPayload) {
                  setAdmobNativeAd(nativeAd.nativeAdView);
                }
              }, onError: (map) {
                log('Ad error - Error: $map', tag: '--native-show');
              });
            }
          }
        },
        {
          'name': 'Destroy Native banner',
          'desc': 'Title is obvious',
          'ready': zoneIds["NATIVE"] != null && adNetwork == 'Google AdMob',
          'onClick': () {
            final ad = admobNativeAd;
            if (ad == null) {
              log('Can not destroy while there is no ad',
                  tag: '--native-destroy');
              return;
            }
            admobNativeAd!.dispose();
            setAdmobNativeLoaded(false);
          }
        },
      ];
}

class TapsellConstant {
  static const app_id =
      'alsoatsrtrotpqacegkehkaiieckldhrgsbspqtgqnbrrfccrtbdomgjtahflchkqtqosa';
  static const interstitial_zone = '5cfaa942e8d17f0001ffb292';
  static const rewarded_video_zone = '5cfaa802e8d17f0001ffb28e';
  static const native_banner_zone = '5cfaa9deaede570001d5553a';
  static const standard_zone = '5cfaaa30e8d17f0001ffb294';

  static const zoneIds = {
    "Tapsell": {
      "REWARDED": '5cfaa802e8d17f0001ffb28e',
      "INTERSTITIAL": '5cfaa942e8d17f0001ffb292',
      "NATIVE": '5cfaa9deaede570001d5553a',
      "STANDARD": '5cfaaa30e8d17f0001ffb294',
    },
    "Google AdMob": {
      "REWARDED": '5cfaa8aee8d17f0001ffb28f',
      "INTERSTITIAL": '5cfaa9b0e8d17f0001ffb293',
      "NATIVE": '5d123c9968287d00019e1a94',
      "STANDARD": '5cfaaa4ae8d17f0001ffb295',
    },
    "AdColony": {
      "REWARDED": '5d3362766de9f600013662d5',
      "INTERSTITIAL": '5d336289e985d50001427acf',
      "STANDARD": '60bf4ef0d40d970001693745',
    },
    "AppLovin": {
      "REWARDED": '5d3eb48c3aef7a0001406f84',
      "INTERSTITIAL": '5d3eb4fa3aef7a0001406f85',
      "STANDARD": '5d3eb5337a9b060001892441',
    },
    "Chart boost": {
      "REWARDED": '5cfaa8cee8d17f0001ffb290',
      "INTERSTITIAL": '60c5b303d756bf0001891f1c'
    },
    "Unity Ads": {
      "REWARDED": '5cfaa8eae8d17f0001ffb291',
      "INTERSTITIAL": '608d1c1c2d8e7e0001348111',
      "STANDARD": '608d20a7fb661b000190bfe4',
    }
  };
}
