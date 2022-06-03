class IswPaymentInfo {
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerMobile;
  final String reference;
  final int amount;

  IswPaymentInfo(
      {required this.customerId,
      required this.customerName,
      required this.customerEmail,
      required this.customerMobile,
      required this.reference,
      required this.amount});

  Map<String, String> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerMobile': customerMobile,
      'reference': reference,
      'amount': amount.toString()
    };
  }
}
