package ir.tapsell.plus.tapsellplus_flutter_example.admob

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import ir.tapsell.plus.tapsell_plus_example.R


class AdmobNativeAdFactory(
    private val context: Context,
    private val adType: NativeAdType
) : GoogleMobileAdsPlugin.NativeAdFactory {

    companion object {
        const val TAG = "AdmobNativeAdFactory"
        const val fullFactoryId = "FullNativeAdFactory"
        const val listItemFactoryId = "ListItemNativeAdFactory"
    }

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val layout: Int =
            if (adType == NativeAdType.LIST_ITEM) R.layout.list_item_native_ad else R.layout.native_ad
        val nativeAdView = LayoutInflater.from(context)
            .inflate(layout, null) as NativeAdView

        Log.d(TAG, "createNativeAd:${nativeAd.body}")

        with(nativeAdView) {
            val attributionViewSmall =
                findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_small)
            val attributionViewLarge =
                findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_large)

            val iconView = findViewById<ImageView>(R.id.iv_list_tile_native_ad_icon)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewSmall.visibility = View.VISIBLE
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            } else {
                attributionViewSmall.visibility = View.INVISIBLE
                attributionViewLarge.visibility = View.VISIBLE
            }
            this.iconView = iconView

            val headlineView = findViewById<TextView>(R.id.tv_list_tile_native_ad_headline)
            headlineView.text = nativeAd.headline
            this.headlineView = headlineView

            val bodyView = findViewById<TextView>(R.id.tv_list_tile_native_ad_body)
            with(bodyView) {
                text = nativeAd.body ?: ""
                visibility = if (text.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            this.bodyView = bodyView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}