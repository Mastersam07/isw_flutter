class IswSdkConfig {
  final String merchantId;
  final String merchantSecret;
  final String merchantCode;
  final String currencyCode;

  IswSdkConfig(
      {required this.merchantId,
      required this.merchantSecret,
      required this.merchantCode,
      required this.currencyCode});

  Map<String, String> toMap() {
    return {
      'merchantId': merchantId,
      'merchantSecret': merchantSecret,
      'merchantCode': merchantCode,
      'currencyCode': currencyCode
    };
  }
}
