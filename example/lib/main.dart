import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:isw_flutter/isw_flutter.dart';
import 'package:isw_flutter_example/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _iswFlutterPlugin = IswFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _iswFlutterPlugin.initialize(IswSdkConfig(
      merchantId: merchantId,
      merchantSecret: merchantSecret,
      merchantCode: merchantCode,
      currencyCode: '566',
    ));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _iswFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void payNow() {
    _iswFlutterPlugin.pay(IswPaymentInfo(
      amount: 100,
      customerEmail: 'abadasamuelosp@gmail.com',
      customerMobile: '08180690050',
      customerId: '389',
      customerName: 'Samuel',
      reference: '449404',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Plugin example app'),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: payNow,
                icon:
                    const Icon(Icons.account_balance_wallet_rounded, size: 50),
                label: const Text('Pay Now'),
              ),
              Text('Running on: $_platformVersion\n'),
            ],
          ),
        ),
      ),
    );
  }
}
