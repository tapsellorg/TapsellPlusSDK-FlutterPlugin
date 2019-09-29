import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tapsell_plus/TapsellPlusNativeBanner.dart';

class TapsellPlus {
  static const MethodChannel _channel = const MethodChannel('tapsell_plus');

  static final VERBOSE = 2;
  static final DEBUG = 3;
  static final INFO = 4;
  static final WARN = 5;
  static final ERROR = 6;
  static final ASSERT = 7;

  static setDebugMode(int logLevel) async {
    await _channel
        .invokeMethod('setDebugMode', <String, dynamic>{'logLevel': logLevel});
  }

  static initialize(String appId) async {
    await _channel
        .invokeMethod('initialize', <String, dynamic>{'appId': appId});
  }

  static addFacebookTestDevice(String hash) async {
    await _channel
        .invokeMethod('addFacebookTestDevice', <String, dynamic>{'hash': hash});
  }

  static Future<Object> requestRewardedVideo(
      String zoneId, Function response, Function error) async {
    return await _channel.invokeMethod('requestRewardedVideo',
        <String, dynamic>{'zoneId': zoneId}).then((value) {
      response(value);
    }).catchError((err) {
      error(err.code, err.message);
    });
  }

  static Future<Object> requestInterstitial(
      String zoneId, Function response, Function error) async {
    return await _channel.invokeMethod('requestInterstitial',
        <String, dynamic>{'zoneId': zoneId}).then((value) {
      response(value);
    }).catchError((err) {
      error(err.code, err.message);
    });
  }

  static Future<Object> requestNativeBanner(
      String zoneId, Function response, Function error) async {
    return await _channel.invokeMethod('requestNativeBanner',
        <String, dynamic>{'zoneId': zoneId}).then((value) {
      Map nativeBannerMap = jsonDecode(value);
      var nativeBanner = TapsellPlusNativeBanner.fromJson(nativeBannerMap);

      response(nativeBanner);
    }).catchError((err) {
      error(err.code, err.message);
    });
  }

  static Future<Object> showAd(
      String zoneId, Function response, Function error) async {
    return await _channel.invokeMethod(
        'showAd', <String, dynamic>{'zoneId': zoneId}).then((value) {
      response(value);
    }).catchError((err) {
      error(err.code, err.message);
    });
  }

  static Future<Object> showBannerAd(String zoneId) async {
    return await _channel
        .invokeMethod('showBannerAd', <String, dynamic>{'zoneId': zoneId});
  }

  static nativeBannerAdClicked(String zoneId, String adId) async {
    await _channel.invokeMethod('nativeBannerAdClicked', <String, dynamic>{
      'zoneId': zoneId,
      'adId': adId,
    });
  }
}
