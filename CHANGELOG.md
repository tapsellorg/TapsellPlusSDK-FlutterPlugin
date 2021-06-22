
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
- Update native dependency to `2.1.3`


## 1.0.0

> **Note**: This version contains old native SDK and is considered deprecated. You are highly recommended to update to a later available version

- Initial release
