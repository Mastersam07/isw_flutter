package tech.mastersam.isw_flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/// Isw SDK - Android sdk imports.
import com.interswitchng.iswmobilesdk.IswMobileSdk
import com.interswitchng.iswmobilesdk.shared.models.core.Environment
import com.interswitchng.iswmobilesdk.shared.models.core.IswPaymentInfo
import com.interswitchng.iswmobilesdk.shared.models.core.IswPaymentResult
import com.interswitchng.iswmobilesdk.shared.models.core.IswSdkConfig

/** IswFlutterPlugin */
class IswFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "isw_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "initialize")  {
      val configMap = call.argument<Map<String, String>>("config")
      val env = call.argument<String>("env")
      assert(configMap != null)
      assert(env != null)
      application?.let { IswMobileSdk.initialize(it, getConfig(configMap, env)) }
      result.success(true)
    } else if (call.method == "pay")  {
      val infoMap = call.argument<Map<String, String>>("paymentInfo")
      IswMobileSdk.instance
          .pay(getPaymentInfo(infoMap), IswSdkCallback(call, result))
    }  else {
      result.notImplemented()
    }
  }

    private fun getConfig(configMap: Map<String, String>?, env: String?): IswSdkConfig {
          // extract configurations
          val merchantId = configMap!!["merchantId"]
          val merchantSecret = configMap["merchantSecret"]
          val merchantCode = configMap["merchantCode"]
          val currencyCode = configMap["currencyCode"]
          val isProduction = env == Environment.PRODUCTION.name
          val isSandbox = env == Environment.SANDBOX.name

          // create configuration
          val config = IswSdkConfig(merchantId, merchantSecrete, merchantCode, currencyCode)

          // set environment
          if (isProduction) config.setEnv(Environment.PRODUCTION) else if (isSandbox) config.setEnv(
              Environment.SANDBOX
          )
          return config
      }

    private fun getPaymentInfo(infoMap: Map<String, String>?): IswPaymentInfo {
        val customerId = infoMap!!["customerId"]
        val customerName = infoMap["customerName"]
        val customerEmail = infoMap["customerEmail"]
        val customerMobile = infoMap["customerMobile"]
        val reference = infoMap["reference"]
        val amount = infoMap["amount"]


        return IswPaymentInfo(
            customerId.toString(),
            customerName.toString(),
            customerEmail.toString(),
            customerMobile.toString(),
            reference.toString(),
            amount.toString().toLong()
        )
    }

    internal class IswSdkCallback(var call: MethodCall, var result: MethodChannel.Result) :
        IswMobileSdk.IswPaymentCallback {
        override fun onUserCancel() {
            result.success(null)
        }

        override fun onPaymentCompleted(iswPaymentResul: IswPaymentResult) {
            result.success(getResult(iswPaymentResul))
        }

        private fun getResult(result: IswPaymentResult): Map<String, String> {
            val map: MutableMap<String, String> = HashMap()
            map["responseCode"] = result.responseCode
            map["responseDescription"] = result.responseDescription
            map["transactionReference"] = result.transactionReference
            map["amount"] = result.amount.toString() + ""
            map["isSuccessful"] = result.isSuccessful.toString() + ""
            map["channel"] = result.channel.name
            return map
        }
    }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
