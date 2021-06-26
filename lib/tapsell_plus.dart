import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void AdCallback();

///
/// Want to do anything with TapsellPlus? Use this class.
///
/// This class gives all the functionality needed for tapsell plus users
///
class TapsellPlus {
  MethodChannel _channel = MethodChannel('tapsell_plus');

  Map<String, void Function(Map<String, String>)> _openCallbacks = {};
  Map<String, void Function(Map<String, String>)> _closeCallbacks = {};
  Map<String, void Function(Map<String, String>)> _rewardCallbacks = {};
  Map<String, void Function(Map<String, String>)> _errorCallbacks = {};

  // Native specific
  Map<String, void Function(NativeAdData)> _nativeCallbacks = {};

  ///
  /// Static modifier for tapsell plus
  /// Instead of defining everything as a static.
  /// Use `TapsellPlus.instance.*`
  ///
  static TapsellPlus instance = TapsellPlus();

  TapsellPlus() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  ///
  /// Initializes the SDK
  /// This method needs and MUST be called before every usage of this plugin
  /// It's also suggested to call this in main()
  ///
  /// [appId] is the Id achieved from tapsell dashboard
  ///
  Future<bool> initialize(String appId) async {
    if (!Platform.isAndroid) return false;
    return await _channel
            .invokeMethod("TapsellPlus.initialize", {'app_id': appId}) ??
        false;
  }

  ///
  /// Sets the user's consent about advertising policy
  /// resolves with true and rejects with false if any issue had occurred
  ///
  Future<bool> setGDPRConsent(bool consent) async {
    if (!Platform.isAndroid) return false;
    return await _channel
            .invokeMethod('TapsellPlus.setGDPRConsent', {'consent': consent}) ??
        false;
  }

  ///
  /// Sets debug mode
  /// [logLevel] determines the level of log cat logs
  ///
  Future<bool> setDebugMode(LogLevel logLevel) async {
    if (!Platform.isAndroid) return false;

    // +2? First log is VERBOSE which is index=2, but in enum it's 0. So +2 will increase them by 2 to match the actual log
    return await _channel.invokeMethod(
        "TapsellPlus.setDebugMode", {'log_level': logLevel.index + 2});
  }

  ///
  /// Requests for an interstitial ad (Gives you an Id to use it for showing it)
  /// Interstitial Ad is a full screen banner.
  /// This method returns **RequestId** as a Future.
  ///
  /// `RequestId` is needed for showing the Ad
  /// You need the [zoneId] of this ad to be able to request for one
  ///
  Future<String> requestInterstitialAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return _toStringOrEmpty(await _channel.invokeMethod(
        'TapsellPlus.requestInterstitialAd', {'zone_id': zoneId}));
  }

  ///
  /// After getting the [responseId] from the request method, use it to show the ad
  /// When the ad is opened to the user, [onOpened] will be called
  /// if the showing has issues and failed to show the ad, [onError] will tell you why
  ///
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

  ///
  /// Requests for an rewarded ad (Gives you an Id to use it for showing it)
  /// RewardedVideo Ad is a full screen video.
  /// This method returns **RequestId** as a Future.
  ///
  /// `RequestId` is needed for showing the Ad
  /// You need the [zoneId] of this ad to be able to request for one
  ///
  Future<String> requestRewardedVideoAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return _toStringOrEmpty(await _channel.invokeMethod(
        'TapsellPlus.requestRewardedVideoAd', {'zone_id': zoneId}));
  }

  ///
  /// Shows the ad requested using the [responseId]
  /// After calling the Ad it will open and call [onOpened],
  /// then starts playing (if completed and not skipped, [onRewarded] will be called - Useful for giving the user some rewards)
  /// then closes with a banner at the end and calls [onClosed]
  ///
  /// If the showing process failed, [onError] will be called with the reason as param
  ///
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

  ///
  /// Requests for and standard banner
  ///
  /// Standard banner is a banner that is not full screen and gets combined to the main view of the app
  ///
  /// **Note**: **This ad uses Main canvas of the application and gets included in the main view**. So **routings will not stop it and it's stay until you hide/destroy it**
  ///  [zoneId] is needed to request one.
  ///  It's shape is specified using [bannerType] param
  ///
  /// Will give you a **responseId** as the result which is needed for showing the ad
  ///
  Future<String> requestStandardBannerAd(
      String zoneId, TapsellPlusBannerType bannerType) async {
    if (!Platform.isAndroid) return "";

    return await _channel.invokeMethod('TapsellPlus.requestStandardBannerAd',
        {'zone_id': zoneId, 'banner_type': bannerType.index});
  }

  ///
  /// Shows the standard banner requested via [responseId]
  ///
  /// To show, you need to specify [horizontalGravity] and [verticalGravity] of the view.
  ///
  /// [onOpened] is called when the ad is opened and added to the page
  /// [onError] is called if any issue has occurred
  ///
  Future<bool> showStandardBannerAd(
      String responseId,
      TapsellPlusHorizontalGravity horizontalGravity,
      TapsellPlusVerticalGravity verticalGravity,
      {EdgeInsets? margin,
      Function(Map<String, String>)? onOpened,
      Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    final top = (margin?.top ?? 0).toInt();
    final bottom = (margin?.bottom ?? 0).toInt();
    final right = (margin?.right ?? 0).toInt();
    final left = (margin?.left ?? 0).toInt();

    if (onOpened != null) _openCallbacks[responseId] = onOpened;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel.invokeMethod('TapsellPlus.showStandardBannerAd', {
      'response_id': responseId,
      'horizontal_gravity': horizontalGravity.index,
      'vertical_gravity': verticalGravity.index,
      'margin_top': top,
      'margin_bottom': bottom,
      'margin_right': right,
      'margin_left': left,
    });
  }

  ///
  /// If the displayed standard banner was hidden using [TapsellPlus.hideStandardBanner], here's Ctrl+Z of it
  ///
  Future<bool> displayStandardBanner() async {
    if (!Platform.isAndroid) return false;

    return await _channel
        .invokeMethod('TapsellPlus.displayStandardBannerAd', {});
  }

  ///
  /// Hides the view component of the standard banner.
  /// **Note**: It will not destroy the ad. It simply hides the view
  ///
  Future<bool> hideStandardBanner() async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod('TapsellPlus.hideStandardBannerAd', {});
  }

  ///
  /// **Destroys** the standard banner which is shown
  /// [responseId] is the Id of the request used to show the ad. And now it's used to destroy it
  /// **Note**: After destroying the ad you need to request a new one in order to show an ad. This responseId is useless now
  ///
  Future<bool> destroyStandardBanner(String responseId) async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod(
        'TapsellPlus.destroyStandardBannerAd', {'response_id': responseId});
  }

  ///
  /// Requests a native ad
  ///
  /// Native ads are a bunch of data given to you so you can show a completely native ad using your own desire and creativity
  ///
  Future<String> requestNativeAd(String zoneId) async {
    if (!Platform.isAndroid) return "";

    return await _channel
        .invokeMethod('TapsellPlus.requestNativeAd', {'zone_id': zoneId});
  }

  ///
  /// Shows the ad using the [responseId] you received from requesting for one
  ///
  /// **When the ad is ready to be shown** [onOpened] is called with the information needed in it's param
  ///
  Future<bool> showNativeAd(String responseId,
      {Function(NativeAdData)? onOpened,
      Function(Map<String, String>)? onError}) async {
    if (!Platform.isAndroid) return false;

    if (onOpened != null) _nativeCallbacks[responseId] = onOpened;
    if (onError != null) _errorCallbacks[responseId] = onError;

    return await _channel
        .invokeMethod('TapsellPlus.showNativeAd', {'response_id': responseId});
  }

  ///
  /// When you show the ad and user presses the nativeAd's call to action button,
  /// you must call this function so the ad process goes correctly
  ///
  /// Ad click is recognized using [responseId] you should store
  ///
  Future<bool> nativeBannerAdClicked(String responseId) async {
    if (!Platform.isAndroid) return false;

    return await _channel.invokeMethod(
        'TapsellPlus.nativeBannerAdClicked', {'response_id': responseId});
  }

  Future<int> _handleMethodCall(MethodCall call) async {
    if (!Platform.isAndroid) return -1;

    final method = call.method;
    final args = _toMap(call.arguments);

    switch (method) {
      case "TapsellPlusListener.onOpened":
        String? responseId = args['response_id'];
        if (responseId == null || responseId.isEmpty) return -1;

        if (args['native_ad'] == null) {
          void Function(Map<String, String>)? c = _openCallbacks[responseId];
          c?.call(args);
        } else {
          // Native Ad - Use native open callbacks
          _nativeCallbacks[responseId]?.call(NativeAdData.fromMap(args));
        }
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

    // check native payload
    if (d['native_ad'] != null) {
      map['native_ad'] = "true";
      if (d['ad_id'] != null) map['ad_id'] = d['ad_id'];
      if (d['title'] != null) map['title'] = d['title'];
      if (d['description'] != null) map['description'] = d['description'];
      if (d['call_to_action_text'] != null)
        map['call_to_action_text'] = d['call_to_action_text'];
      if (d['icon_url'] != null) map['icon_url'] = d['icon_url'];
      if (d['portrait_static_image_url'] != null)
        map['portrait_static_image_url'] = d['portrait_static_image_url'];
      if (d['landscape_static_image_url'] != null)
        map['landscape_static_image_url'] = d['landscape_static_image_url'];
    }
    return map;
  }
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
/// Used for showing standard banner
///
// **Note**:
//   Order of these matter. Their index is used in native-side.
//   TOP: 0, CENTER: 1, BOTTOM: 2
///
enum TapsellPlusHorizontalGravity { TOP, CENTER, BOTTOM }

///
/// Used for showing standard banner
///
// **Note**:
//   Order of these matter. Their index is used in native-side.
//   LEFT: 0, CENTER: 1, RIGHT: 2
///
enum TapsellPlusVerticalGravity { LEFT, CENTER, RIGHT }

///
/// Log level is used when setting debug mode
///
enum LogLevel { Verbose, Debug, Info, Warn, Error, Assert }

///
/// NativeAd util class, so the developer does not need to work with plain dictionary and instead typed class is ready
///
class NativeAdData {
  String? zoneId,
      responseId,
      adId,
      title,
      description,
      callToActionText,
      iconUrl,
      portraitImageUrl,
      landscapeImageUrl;

  NativeAdData(
      this.zoneId,
      this.responseId,
      this.adId,
      this.title,
      this.description,
      this.callToActionText,
      this.iconUrl,
      this.portraitImageUrl,
      this.landscapeImageUrl);

  static NativeAdData fromMap(Map<String, String?> map) {
    return NativeAdData(
        map['zone_id'],
        map['response_id'],
        map['ad_id'],
        map['title'],
        map['description'],
        map['call_to_action_text'],
        map['icon_url'],
        map['portrait_static_image_url'],
        map['landscape_static_image_url']);
  }

  Map<String, String> toMap() {
    Map<String, String> map = {};
    if (zoneId != null) map['zone_id'] = zoneId!;
    if (responseId != null) map['response_id'] = responseId!;
    if (adId != null) map['ad_id'] = adId!;
    if (title != null) map['title'] = title!;
    if (description != null) map['description'] = description!;
    if (callToActionText != null)
      map['call_to_action_text'] = callToActionText!;
    if (iconUrl != null) map['icon_url'] = iconUrl!;
    if (portraitImageUrl != null)
      map['portrait_static_image_url'] = portraitImageUrl!;
    if (landscapeImageUrl != null)
      map['landscape_static_image_url'] = landscapeImageUrl!;
    return map;
  }
}
