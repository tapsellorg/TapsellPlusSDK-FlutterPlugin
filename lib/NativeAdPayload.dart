import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'NativeAdData.dart';

///
/// NativeAdPayload util class, used to handle different states of NativeAd (general, admob)
///
abstract class NativeAdPayload {
  NativeAdPayload._();

  factory NativeAdPayload.general(NativeAdData ad) =>
      GeneralNativeAdPayload(ad);

  factory NativeAdPayload.adMob(Ad ad) => AdMobNativeAdPayload(ad);

  factory NativeAdPayload.adMobView(NativeAd nativeAd) =>
      AdMobNativeAdViewPayload(nativeAd);
}

class GeneralNativeAdPayload extends NativeAdPayload {
  NativeAdData ad;

  GeneralNativeAdPayload(this.ad) : super._();
}

class AdMobNativeAdPayload extends NativeAdPayload {
  Ad ad;

  AdMobNativeAdPayload(this.ad) : super._();
}

class AdMobNativeAdViewPayload extends NativeAdPayload {
  NativeAd nativeAdView;

  AdMobNativeAdViewPayload(this.nativeAdView) : super._();
}
