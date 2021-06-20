import 'dart:io';

import 'package:flutter/services.dart';

typedef void AdCallback();

class TapsellPlus {
  MethodChannel _channel = MethodChannel('tapsell_plus');

  Map<String, void Function(Map<String, String>)> _openCallbacks = {};
  Map<String, void Function(Map<String, String>)> _closeCallbacks = {};
  Map<String, void Function(Map<String, String>)> _rewardCallbacks = {};
  Map<String, void Function(Map<String, String>)> _errorCallbacks = {};


  /// Static modifier for tapsell plus
  /// Instead of defining everything as a static.
  /// Use `TapsellPlus.instance.*`
  static TapsellPlus instance = TapsellPlus();

  TapsellPlus() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<bool> initialize(String appId) async {
    if (!Platform.isAndroid) return false;
    return await _channel.invokeMethod("TapsellPlus.initialize", {'app_id': appId});
  }

  Future<bool> setDebugMode(int logLevel) async {
    if (!Platform.isAndroid) return false;

    return await _channel
        .invokeMethod("TapsellPlus.setDebugMode", {'log_level': logLevel});
  }

  Future<String> requestInterstitialAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return _toStringOrEmpty(await _channel.invokeMethod(
        'TapsellPlus.requestInterstitialAd', {
      'zone_id': zoneId
    }));
  }

  Future<bool> showInterstitialAd(String responseId,
      {Function(Map<String, String>)? onOpened,
      Function(Map<String, String>)? onClosed,
      Function(Map<String, String>)? onRewarded,
      Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    if (onOpened != null) _openCallbacks[responseId] = onOpened;
    if (onClosed != null) _closeCallbacks[responseId] = onClosed;
    if (onRewarded != null) _rewardCallbacks[responseId] = onRewarded;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel.invokeMethod(
        'TapsellPlus.showInterstitialAd', {'response_id': responseId});
  }

  Future<String> requestRewardedVideoAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return _toStringOrEmpty(await _channel.invokeMethod(
        'TapsellPlus.requestRewardedVideoAd', {'zone_id': zoneId}));
  }

  Future<bool> showRewardedVideoAd(String responseId,
      {Function(Map<String, String>)? onOpened,
      Function(Map<String, String>)? onClosed,
      Function(Map<String, String>)? onRewarded,
      Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    if (onOpened != null) _openCallbacks[responseId] = onOpened;
    if (onClosed != null) _closeCallbacks[responseId] = onClosed;
    if (onRewarded != null) _rewardCallbacks[responseId] = onRewarded;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel.invokeMethod(
        'TapsellPlus.showRewardedVideoAd', {'response_id': responseId});
  }

  Future<String> requestStandardBannerAd(
      String zoneId, TapsellPlusBannerType bannerType) async {
    if (!Platform.isAndroid) return "";

    return await _channel.invokeMethod('TapsellPlus.requestStandardBannerAd',
        {'zone_id': zoneId, 'banner_type': bannerType.index});
  }

  Future<bool> showStandardBannerAd(
      String responseId,
      TapsellPlusHorizontalGravity horizontalGravity,
      TapsellPlusVerticalGravity verticalGravity,
      {Function(Map<String, String>)? onOpened,
      Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    if (onOpened != null) _openCallbacks[responseId] = onOpened;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel.invokeMethod('TapsellPlus.showStandardBannerAd', {
      'response_id': responseId,
      'horizontal_gravity': horizontalGravity.index,
      'vertical_gravity': verticalGravity.index
    });
  }

  Future<bool> displayStandardBanner() async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod('TapsellPlus.displayStandardBannerAd', {});
  }

  Future<bool> hideStandardBanner() async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod('TapsellPlus.hideStandardBannerAd', {});
  }

  Future<bool> destroyStandardBanner(String responseId) async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod('TapsellPlus.destroyStandardBannerAd', { 'response_id': responseId });
  }

  Future<String> requestNativeAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return await _channel.invokeMethod('TapsellPlus.requestNativeAd', { 'zone_id': zoneId });
  }

  Future<bool> showNativeAd(String responseId,
      {Function(Map<String, String>)? onOpened,
        Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    if (onOpened != null) _openCallbacks[responseId] = onOpened;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel.invokeMethod('TapsellPlus.showNativeAd', { 'response_id' : responseId });
  }

  Future<bool> nativeBannerAdClicked(String responseId) async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod('TapsellPlus.nativeBannerAdClicked', { 'response_id' : responseId });
  }

  //////////////

  Future<int> _handleMethodCall(MethodCall call) async {
    if (!Platform.isAndroid) return -1;

    final method = call.method;
    final args = _toMap(call.arguments);
    _log("""
    Call from native side: $method
    Args(Non-Map): ${call.arguments}
    Type of args: ${call.arguments.runtimeType}
    """);

    switch (method) {
      case "TapsellPlusListener.onOpened":
        String? responseId = args['response_id'];
        if (responseId == null || responseId.isEmpty) return -1;
        void Function(Map<String, String>)? c = _openCallbacks[responseId];
        c?.call(args);
        break;
      case "TapsellPlusListener.onClosed":
        String? responseId = args['response_id'];
        if (responseId == null || responseId.isEmpty) return -1;
        void Function(Map<String, String>)? c = _closeCallbacks[responseId];
        c?.call(args);
        break;
      case "TapsellPlusListener.onRewarded":
        String? responseId = args['response_id'];
        if (responseId == null || responseId.isEmpty) return -1;
        void Function(Map<String, String>)? c = _rewardCallbacks[responseId];
        c?.call(args);
        break;
      case "TapsellPlusListener.onError":
        String? responseId = args['response_id'];
        if (responseId == null || responseId.isEmpty) return -1;
        void Function(Map<String, String>)? c = _errorCallbacks[responseId];
        c?.call(args);
        break;
      default:
        return -1;
    }
    return 0;
  }

  String _toStringOrEmpty(dynamic d) {
    if (d is String)
      return d;
    else
      return "";
  }

  Map<String, String> _toMap(dynamic d) {
    final Map<String, String> map = Map();
    if (d['zone_id'] != null) map['zone_id'] = d['zone_id'];
    if (d['response_id'] != null) map['response_id'] = d['response_id'];
    if (d['error_message'] != null) map['error_message'] = d['error_message'];

    if(d['ad_id'] != null) {
      map['ad_id'] = d['ad_id'];
      if (d['title'] != null) map['title'] = d['title'];
      if (d['description'] != null) map['description'] = d['description'];
      if (d['call_to_action_text'] != null) map['call_to_action_text'] = d['call_to_action_text'];
      if (d['icon_url'] != null) map['icon_url'] = d['icon_url'];
      if (d['portrait_static_image_url'] != null) map['portrait_static_image_url'] = d['portrait_static_image_url'];
      if (d['landscape_static_image_url'] != null) map['landscape_static_image_url'] = d['landscape_static_image_url'];
    }
    return map;
  }

  _log(String message) => print('[TapsellPlus-Flutter]: $message');
}

enum TapsellPlusBannerType {
  BANNER_320x50,
  BANNER_320x100,
  BANNER_250x250,
  BANNER_300x250,
  BANNER_468x60,
  BANNER_728x90
}

///
/// **Note**:
///   Order of these matter. Their index is used in native-side.
///   TOP: 0, CENTER: 1, BOTTOM: 2
///
enum TapsellPlusHorizontalGravity { TOP, CENTER, BOTTOM }

///
/// **Note**:
///   Order of these matter. Their index is used in native-side.
///   LEFT: 0, CENTER: 1, RIGHT: 2
///
enum TapsellPlusVerticalGravity { LEFT, CENTER, RIGHT }
