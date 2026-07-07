class UpiQrService {
  static String generateUri({
    required String upiId,
    required String payeeName,
    required num amount,
    String note = '',
    String currency = 'INR',
    String transactionRef = '',
    String merchantCode = '',
  }) {
    return Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: {
        'pa': upiId,                 // UPI ID
        'pn': payeeName,             // Merchant Name
        'am': amount.toStringAsFixed(2),
        'cu': currency,
        if (note.isNotEmpty) 'tn': note,
        if (transactionRef.isNotEmpty) 'tr': transactionRef,
        if (merchantCode.isNotEmpty) 'mc': merchantCode,
      },
    ).toString();
  }
}