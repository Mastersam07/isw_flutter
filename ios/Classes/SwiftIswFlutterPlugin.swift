import Flutter
import UIKit
import IswMobileSdk

public class SwiftIswFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "isw_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftIswFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "initialize":
            let arguments = call.arguments as! [String:Any]

            let configMap = (arguments["config"] as! [String:String])
            let env = arguments["env"] as! String

            
            let merchantCode = configMap["merchantCode"]
            let clientSecret = configMap["merchantSecret"]
            let clientId = configMap["merchantId"]
            let currencyCode = configMap["currencyCode"]
        let usedEnv = env == "test" ? Environment.sandbox : Environment.production
            if (merchantCode == nil ){
                result(false)
            }else if (clientSecret == nil){
                result(false)
            }else if (clientId == nil){
                result(false)
            }else if (currencyCode == nil){
                result(false)
            }else{

                // create merchant configuration
                let config = IswSdkConfig(
                    clientId: clientId!,
                    clientSecret: clientSecret!,
                    currencyCode: currencyCode!,
                    merchantCode: merchantCode!
                )

                // initialize sdk
                IswMobileSdk.intialize(config: config, env: usedEnv)
                result(true)
            }
        case "pay":
            result(FlutterMethodNotImplemented)
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
