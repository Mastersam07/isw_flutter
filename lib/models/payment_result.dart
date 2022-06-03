import '../enums.dart';

class IswPaymentResult {
  final String responseCode;
  final String responseDescription;
  final bool isSuccessful;
  final String transactionReference;
  final int amount;
  final PaymentChannel channel;

  IswPaymentResult(this.responseCode, this.responseDescription,
      this.isSuccessful, this.transactionReference, this.amount, this.channel);

  static IswPaymentResult fromJson(Map<dynamic, dynamic> json) {
    final isSuccessful = json['isSuccessful'].toLowerCase() == 'true';

    final providedChannel = json['channel'];
    PaymentChannel channel;
    if (providedChannel == nameOf(PaymentChannel.card)) {
      channel = PaymentChannel.card;
    } else if (providedChannel == nameOf(PaymentChannel.wallet)) {
      channel = PaymentChannel.wallet;
    } else if (providedChannel == nameOf(PaymentChannel.ussd)) {
      channel = PaymentChannel.ussd;
    } else if (providedChannel == nameOf(PaymentChannel.qr)) {
      channel = PaymentChannel.qr;
    } else {
      channel = PaymentChannel.paycode;
    }

    return IswPaymentResult(
        json['responseCode'],
        json['responseDescription'],
        isSuccessful,
        json['transactionReference'],
        int.parse(json['amount']),
        channel);
  }

  static String nameOf(PaymentChannel channel) {
    final name = channel.toString();
    return name.substring(name.indexOf('.') + 1);
  }
}

class Optional<T> {
  final T? value;
  final bool hasValue;

  Optional(this.value, this.hasValue);
}
