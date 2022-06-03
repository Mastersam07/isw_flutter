import 'package:isw_flutter/enums.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'isw_flutter_method_channel.dart';
import 'models/config.dart';
import 'models/payment_info.dart';
import 'models/payment_result.dart';

abstract class IswFlutterPlatform extends PlatformInterface {
  /// Constructs a IswFlutterPlatform.
  IswFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static IswFlutterPlatform _instance = MethodChannelIswFlutter();

  /// The default instance of [IswFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelIswFlutter].
  static IswFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IswFlutterPlatform] when
  /// they register themselves.
  static set instance(IswFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets platform version.
  Future<String?> getPlatformVersion();

  /// Initializes the IswFlutter SDK.
  Future<bool?> initialize(IswSdkConfig config,
      [Environment env = Environment.test]);

  /// Starts a payment.
  Future<Optional<IswPaymentResult>> pay(IswPaymentInfo info);
}
