
## 2.2.0 (27 Jun, 2023)
- [fix]: Fixed Google Play policy error related to Collecting user's installed apps [GH-68](https://github.com/tapsellorg/TapsellPlusSDK-AndroidSample/issues/68
- [**New**]: Added new UI for back dialog in rewarded videos
- [change] Update Android dependency (TapsellPlus) to [`2.2.0`](https://docs.tapsell.ir/plus-sdk/android/main/#20220621-220)
- [change]: Update `google_mobile_ads` to `3.0.0` and native Admob to `V22.0.0`
- [fix]: Fix some memory leaks in tapsell sdk and tapsell plus sdk
- [fix]: fix some proguard issues
- [fix]: Fix wrong back dialog options in rewarded videos
- [chore]: Update UnityAds to `V4.6.1`
- [chore]: Update Mintegral to `V16.3.91`
- [chore]: Update AdColony to `V4.8.0`
- [chore]: Update AppLovin to `V11.8.2`

## 2.1.8 (17 June, 2023)
- [feat] Add support for `Admob native banner`
- [Change]: Update `minSdkVersion` to 19 to support `google_mobile_ads:V1.3.0`
- [change] Update Android dependency (TapsellPlus) to [`2.1.8`](https://docs.tapsell.ir/plus-sdk/android/main/#v218---20221121)
- [change] Update Android `targetSdkVersion` to 33
- [New] Added dynamic configs for `backPressed` final banner in video ads
- [New] Add dynamic configs for back alert dialog in videos
- [Fix] Update UnityAds to `V4.3.0` and fix deprecations based on ([UnityAds API](https://docs.unity.com/ads/UnityAPI.html))

## 2.1.7 
- [feat] Update native dependency to [`2.1.7`](https://docs.tapsell.ir/plus-sdk/android/main/#v217---20220328)
  - [feat] Update admob to `20.6.0`
  - [fix] Fix SSLFactory on Android versions prior to 4.4
- [fix] Standard banner tag issue

## 2.1.7-alpha01
- [feat] Update native dependency to [`2.1.7`](https://docs.tapsell.ir/plus-sdk/android/main/#v217---20220328)
- [fix] Standard banner tag issue

## 2.1.6
- [**New**] Add Vast Activity like Github Sample
- [**New**] Add AppSetId due to new changes to advertisingId
- [**New**] Add support for Mintegral Interstitial and Rewarded Ads
- [**New**] Add support for Mintegral standard banner ads
- [*Fix*] Fixed consistent request in VAST  
- [*Fix*] Fixed Admob native banner crash 
- [*Fix*] Fixed Tapsell Native Banner NullPointerException
- [*Fix*] Fixed Standard banner refresh issue: it will now remove the previous banner if the request was failed and banner was not in shown state
    - Modified adNetworks: AppLovin, AdMob, Tapsell, Mintegral
- [change] Update Android dependency (TapsellPlus) to 2.1.6
- [change] update **Tapsell** adNetwork version to 4.7.4
- [change] Update targetSDK version to 31
- [change] Error will notify more verbosely when all adNetworks failed to load

## 2.1.4
- [**New**] Add AdColony Standard Banner
- [**New**] Add Chartboost Interstitial Ad
- [fix] Fix activity null issue
- [fix] Fix Activity assignment after config changes
- [fix] Fix the invalid activity message
- [change] Update Android dependency (TapsellPlus) to 2.1.3


## 2.1.3
- [**New**] Add `setGDPRConsent` method
- [change] Add `margin` parameter to `showStandardBanner` method which takes an `EdgeInsets` and sets the native margin
- [fix] Native ad `onOpened` invocation issue
- [change] Update Android dependency to 2.1.3-rc01

## 2.1.2
- [**New**] Null-safety support
- [**Breaking**] `ios` part of the app is removed. It will be added when the SDK actually supports the iOS
- [**Breaking**] Plugin is re-written. So all methods are made using newer sdk. Almost everything is different.
- [change] Add util classes such as `NativeAd` and `LogLevel` to provide easier APIs
- [change] `TapsellPlus#setDebugMode`'s input changed from `int` to `LogLevel`
- [change] `showNativeAd(onOpened)` callback will now give you a `NativeAd` instead of Map


## 2.0.0-nullsafety.2
- [**Chore**] Update usage information

## 2.0.0-nullsafety.1
- [**Chore**] Update License
- [**Chore**] Update README and usage information

## 2.0.0-nullsafety.0
- [**New**] Migrate to **NullSafety**
- [**Breaking**] All methods are re-written due to major changes in native SDK
- [**Breaking**] Remove `ios` part of the plugin. IOS is not supported at this point.

#### Android
- Update native dependency to `2.1.2`


## 1.0.0

> **Note**: This version contains old native SDK and is considered deprecated. You are highly recommended to update to a later available version

- Initial release
