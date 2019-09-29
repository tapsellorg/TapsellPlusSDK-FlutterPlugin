package ir.tapsell.tapsell_plus

import android.app.Activity
import android.util.Log
import android.view.ViewGroup
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import ir.tapsell.plus.*

class TapsellPlusPlugin(private val activity: Activity) : MethodCallHandler {

    private val TAG = "TapsellPlusFlutter"

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "tapsell_plus")
            channel.setMethodCallHandler(TapsellPlusPlugin(registrar.activity()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.d(TAG, call.method)
        when (call.method) {
            "initialize" -> {
                val appId: String = call.argument("appId")!!
                TapsellPlus.initialize(activity, appId)
            }
            "setDebugMode" -> {
                val logLevel: Int = call.argument("logLevel") ?: Log.DEBUG
                TapsellPlus.setDebugMode(logLevel)
            }
            "addFacebookTestDevice" -> {
                val hash: String = call.argument("hash")!!
                TapsellPlus.addFacebookTestDevice(hash)
            }
            "requestRewardedVideo" -> {
                val zoneId: String = call.argument("zoneId")!!
                TapsellPlus.requestRewardedVideo(activity, zoneId, object : AdRequestCallback() {
                    override fun response() {
                        Log.d(TAG, "${call.method}Response")
                        result.success(zoneId)
                    }

                    override fun error(message: String?) {
                        Log.e(TAG, "${call.method}Error")
                        result.error(zoneId, message, null)
                    }
                })
            }
            "requestInterstitial" -> {
                val zoneId: String = call.argument("zoneId")!!
                TapsellPlus.requestInterstitial(activity, zoneId, object : AdRequestCallback() {
                    override fun response() {
                        Log.d(TAG, "${call.method}Response")
                        result.success(zoneId)
                    }

                    override fun error(message: String?) {
                        Log.e(TAG, "${call.method}Error")
                        result.error(zoneId, message, null)
                    }
                })
            }
            "requestNativeBanner" -> {
                val zoneId: String = call.argument("zoneId")!!
                TapsellPlus.requestNativeBanner(activity, zoneId, object : AdRequestCallback() {
                    override fun response() {
                        Log.d(TAG, "${call.method}Response")
                        requestNativeBannerResponse(zoneId, result)
                    }

                    override fun error(message: String?) {
                        Log.e(TAG, "${call.method}Error")
                        result.error(zoneId, message, null)
                    }
                })
            }
            "showAd" -> {
                val zoneId: String = call.argument("zoneId")!!
                TapsellPlus.showAd(activity, null, false, zoneId, object : AdShowListener() {
                    override fun onOpened() {
                        Log.e(TAG, "${call.method}AdOpened")
                        try {
                            val response = TapsellPlusResponseModel(zoneId, "AdOpened")
                            result.success(Gson().toJson(response))
                        } catch (e: Exception) {
                            Log.e(TAG, e.message)
                            result.error(zoneId, e.message, null)
                        }
                    }

                    override fun onClosed() {
                        Log.e(TAG, "${call.method}AdClosed")
                        try {
                            val response = TapsellPlusResponseModel(zoneId, "AdClosed")
                            result.success(Gson().toJson(response))
                        } catch (e: Exception) {
                            Log.e(TAG, e.message)
                            result.error(zoneId, e.message, null)
                        }
                    }

                    override fun onRewarded() {
                        Log.e(TAG, "${call.method}AdRewarded")
                        try {
                            val response = TapsellPlusResponseModel(zoneId, "AdRewarded")
                            result.success(Gson().toJson(response))
                        } catch (e: Exception) {
                            Log.e(TAG, e.message)
                            result.error(zoneId, e.message, null)
                        }
                    }

                    override fun onError(message: String?) {
                        Log.e(TAG, "${call.method}AdError")
                        result.error(zoneId, message, null)
                    }
                })
            }
            "showBannerAd" -> {
                val zoneId: String = call.argument("zoneId")!!
                val bannerType: TapsellPlusBannerType = call.argument("bannerType")!!
                val adContainer: ViewGroup = call.argument("adContainer")!!

                TapsellPlus.showBannerAd(
                        activity,
                        adContainer,
                        zoneId,
                        bannerType, object : AdRequestCallback() {
                    override fun response() {
                        Log.d(TAG, "${call.method}Response")
                        requestNativeBannerResponse(zoneId, result)
                    }

                    override fun error(message: String?) {
                        Log.e(TAG, "${call.method}Error")
                        result.error(zoneId, message, null)
                    }
                })
            }
            "nativeBannerAdClicked" -> {
                val zoneId: String = call.argument("zoneId")!!
                val adId: String = call.argument("adId")!!

                TapsellPlus.nativeBannerAdClicked(activity, zoneId, adId)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun requestNativeBannerResponse(zoneId: String, result: Result) {
        try {
            val tapsellPlusNativeBanner: TapsellPlusNativeBanner =
                    TapsellPlus.getNativeBannerObject(activity, zoneId)

            if (tapsellPlusNativeBanner.error) {
                result.error(zoneId, tapsellPlusNativeBanner.errorMessage, null)
                return
            }

            val json = Gson().toJson(tapsellPlusNativeBanner)
            Log.e(TAG, json)
            result.success(json)
        } catch (e: Exception) {
            Log.e(TAG, e.message)
        }
    }
}
