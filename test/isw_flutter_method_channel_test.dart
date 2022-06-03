import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isw_flutter/isw_flutter_method_channel.dart';
import 'package:isw_flutter/models/config.dart';
import 'package:isw_flutter/models/payment_info.dart';
import 'package:isw_flutter/models/payment_result.dart';

void main() {
  MethodChannelIswFlutter platform = MethodChannelIswFlutter();
  const MethodChannel channel = MethodChannel('isw_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();
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
      channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getPlatformVersion':
              return '42';
            case 'initialize':
              return true;
            case 'pay':
              return {
                "isSuccessful": "true",
                "responseCode": "00",
                "responseDescription": "Successful",
                "transactionReference": "transactionReference",
                "amount": "500",
                "channel": "card"
              };
          }
        },
      );
    },
  );

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('initialize', () async {
    bool? init = await platform.initialize(config);
    expect(init, true);
  });

  test('pay has data', () async {
    Optional<IswPaymentResult> pay = await platform.pay(info);
    expect(pay.hasValue, true);
  });

  test('pay has correct amount', () async {
    Optional<IswPaymentResult> pay = await platform.pay(info);
    expect(pay.value?.amount, 500);
  });
}
