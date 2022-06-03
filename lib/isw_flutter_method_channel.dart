import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isw_flutter/models/payment_result.dart';
import 'package:isw_flutter/models/payment_info.dart';
import 'package:isw_flutter/models/config.dart';
import 'package:isw_flutter/enums.dart';
import 'package:isw_flutter/util.dart';

import 'isw_flutter_platform_interface.dart';

/// An implementation of [IswFlutterPlatform] that uses method channels.
class MethodChannelIswFlutter extends IswFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('isw_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> initialize(IswSdkConfig config,
      [Environment env = Environment.test]) {
    final init = methodChannel.invokeMethod<bool>(
        'initialize', {'config': config.toMap(), 'env': nameOf(env)});
    return init;
  }

  @override
  Future<Optional<IswPaymentResult>> pay(IswPaymentInfo info) async {
    final result =
        await methodChannel.invokeMethod('pay', {'paymentInfo': info.toMap()});
    if (result == null) {
      return Optional(result, false);
    } else {
      return Optional(IswPaymentResult.fromJson(result), true);
    }
  }
}
