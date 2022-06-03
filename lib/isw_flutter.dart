import 'enums.dart';
import 'isw_flutter_platform_interface.dart';
import 'models/config.dart';
import 'models/payment_info.dart';
import 'models/payment_result.dart';

class IswFlutter {
  Future<String?> getPlatformVersion() {
    return IswFlutterPlatform.instance.getPlatformVersion();
  }

  Future<bool?> initialize(IswSdkConfig config, [Environment? env]) {
    return IswFlutterPlatform.instance.initialize(config);
  }

  Future<Optional<IswPaymentResult>> pay(IswPaymentInfo info) {
    return IswFlutterPlatform.instance.pay(info);
  }
}
