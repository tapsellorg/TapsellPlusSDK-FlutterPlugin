package ir.tapsell.plus.tapsellplus_flutter_example

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import ir.tapsell.plus.tapsellplus_flutter_example.admob.AdmobNativeAdFactory
import ir.tapsell.plus.tapsellplus_flutter_example.admob.NativeAdType


class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        registerNativeAdFactory()
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        unregisterNativeAdFactory()
    }

    private fun registerNativeAdFactory() {
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            AdmobNativeAdFactory.listItemFactoryId,
            AdmobNativeAdFactory(context, NativeAdType.LIST_ITEM)
        );

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            AdmobNativeAdFactory.fullFactoryId,
            AdmobNativeAdFactory(context, NativeAdType.FULL)
        );
    }

    private fun unregisterNativeAdFactory() {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
            flutterEngine,
            AdmobNativeAdFactory.listItemFactoryId
        );

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
            flutterEngine,
            AdmobNativeAdFactory.fullFactoryId
        );
    }
}
