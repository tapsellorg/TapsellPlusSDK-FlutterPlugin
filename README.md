# Tapsell plus

**Tapsell Plus** is a multi-platform mediator advertising SDK.  
With Tapsell plus, you can get grow your advertising income with the favor of using multiple AdNetworks that is best for the at the moment.  

## Installation

**Stable release**

Stable releases (and pre-release) versions are published in pub and accessible directly


```yaml
dependencies:
  tapsell_plus: <latest>
```

version: ![latest](https://img.shields.io/pub/v/tapsell_plus?label=tapsell_plus&style=plastic)

**Latest changes**

If you want to access the newest features (not necessarily stable nor released in pub), you need to fetch the package from github:

```yaml
tapsell_plus:
  git:
    url: https://github.com/tapsellorg/TapsellPlusSDK-FlutterPlugin.git
```

## Usage

Use `TapsellPlus.instance.` to access functionalities and methods

### Initialization

```dart
void main() {
  TapsellPlus.instance.initialize(appId); // AppId from tapsell-dashboard
  runApp(MyApp());
}
```

> Inserting `initialize` in the `main()` is **optional, but recommended**


### Request an Ad

> **Note**: The process of showing and ad is:  
>
> - Request an Ad using the `zoneId` and get a `responseId`
> - Use the `responseId` to show the ad


```dart
final zoneId = "a_zoneId_for_this_type_of_ad";

// Callback way
TapsellPlus.instance.requestInterstitialAd(zoneId).then((responseId) {
  // Save the responseId -- You need it for showing the ad
}).catchError((error) {
  // Error occurred
});

// async-await way

final responseId = await TapsellPlus.instance.requestInsterstitialAd(zoneId);
```

### Show the Ad

Have the saved `responseId` of the request you just called

```dart
TapsellPlus.instance.showInterstitialAd(id,
   onOpened: (map) {
     // Ad opened - Map contains zone_id and response_id
   },
   onError: (map) {
     // Ad failed to show - Map contains error_message, zone_id and response_id
   }
);
```

> Showing an Ad might contain one or more of `onOpened`, `onClosed`, `onRewarded` and `onError` callbacks.

Different supported ad types are:

|ad type|supported|
|:--:|:--:|
|Standard banner|✅|
|Interstitial banner|✅|
|Rewarded video|✅|
|Native ad|✅|

## Documentations

Refer to [tapsell plus documentation](https://docs.tapsell.ir/sdk/) for details and more information.

### Issues and question

**Got any issues, bugs or have any questions?** Checkout the [**Github issues**](https://github.com/tapsellorg/TapsellPlusSDK-FlutterPlugin/issues?q=is%3Aissue) or even [create one](https://github.com/tapsellorg/TapsellPlusSDK-FlutterPlugin/issues/new) if not asked before. 
