import 'package:flutter_test/flutter_test.dart';
import 'package:isw_flutter/enums.dart';
import 'package:isw_flutter/isw_flutter.dart';
import 'package:isw_flutter/isw_flutter_platform_interface.dart';
import 'package:isw_flutter/isw_flutter_method_channel.dart';
import 'package:isw_flutter/util.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIswFlutterPlatform
    with MockPlatformInterfaceMixin
    implements IswFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> initialize(IswSdkConfig config,
          [Environment env = Environment.test]) =>
      Future.value(true);

  @override
  Future<Optional<IswPaymentResult>> pay(IswPaymentInfo info) =>
      Future.value(Optional(null, false));
}

void main() {
  final IswFlutterPlatform initialPlatform = IswFlutterPlatform.instance;

  late IswSdkConfig config;
  late IswPaymentInfo info;

  setUp(
    () {
      config = IswSdkConfig(
        merchantId: 'merchantId',
        merchantSecret: 'merchantSecret',
        currencyCode: 'currencyCode',
        merchantCode: 'merchantCode',
      );
      info = IswPaymentInfo(
          amount: 500,
          customerEmail: 'customerEmail',
          customerId: 'customerId',
          customerMobile: 'customerMobile',
          customerName: 'customerName',
          reference: 'reference');
    },
  );

  test('$MethodChannelIswFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIswFlutter>());
  });

  test('getPlatformVersion', () async {
    IswFlutter iswFlutterPlugin = IswFlutter();
    MockIswFlutterPlatform fakePlatform = MockIswFlutterPlatform();
    IswFlutterPlatform.instance = fakePlatform;

    expect(await iswFlutterPlugin.getPlatformVersion(), '42');
  });

  test('initialize', () async {
    IswFlutter iswFlutterPlugin = IswFlutter();
    MockIswFlutterPlatform fakePlatform = MockIswFlutterPlatform();
    IswFlutterPlatform.instance = fakePlatform;

    expect(await iswFlutterPlugin.initialize(config), true);
  });

  test('pay', () async {
    IswFlutter iswFlutterPlugin = IswFlutter();
    MockIswFlutterPlatform fakePlatform = MockIswFlutterPlatform();
    IswFlutterPlatform.instance = fakePlatform;
    Optional<IswPaymentResult> pay = await iswFlutterPlugin.pay(info);

    expect(pay.hasValue, false);
  });

  test('nameOf', () async {
    expect(nameOf(Environment.test), 'test');
  });
}
