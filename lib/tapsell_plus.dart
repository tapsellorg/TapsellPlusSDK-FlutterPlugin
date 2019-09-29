import 'package:flutter/services.dart';

class TapsellPlus {
  static const MethodChannel _channel = const MethodChannel('tapsell_plus');

  /*static get showAlertDialog async {
    await _channel.invokeMethod('showAlertDialog');
  }*/

  /*static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }*/

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

  static Future<Object> requestRewardedVideo(String zoneId) async {
    return await _channel.invokeMethod(
        'requestRewardedVideo', <String, dynamic>{'zoneId': zoneId});
  }

  static Future<Object> requestInterstitial(String zoneId) async {
    return await _channel.invokeMethod(
        'requestInterstitial', <String, dynamic>{'zoneId': zoneId});
  }

  static Future<Object> requestNativeBanner(String zoneId) async {
    return await _channel.invokeMethod(
        'requestNativeBanner', <String, dynamic>{'zoneId': zoneId});
  }

  static Future<Object> showAd(String zoneId) async {
    return await _channel
        .invokeMethod('showAd', <String, dynamic>{'zoneId': zoneId});
  }
}
