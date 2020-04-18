class PaySaleRequest {
  
  String buyerName;
  String buyerPhone;
  String buyerEmail;
  String buyerSocialID;
  String installments;
  String paymentSaleID;
  String creditCardNumber;
  String creditCardCVV;
  String creditCardExp;

  PaySaleRequest({this.buyerEmail, this.buyerName, this.buyerPhone, this.buyerSocialID, this.creditCardCVV, this.creditCardExp, this.creditCardNumber, this.installments, this.paymentSaleID});

  factory PaySaleRequest.def(String paymentSaleID) {
    return PaySaleRequest(
      buyerEmail: 'example@example.com',
      buyerName: 'Example',
      buyerPhone: '999999999',
      buyerSocialID: '0000000000',
      creditCardCVV: '123',
      creditCardExp: '1221',
      creditCardNumber: '4580458045804580',
      installments: '1',
      paymentSaleID: paymentSaleID
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'buyerPhone': buyerPhone,
      'buyerName': buyerName,
      'buyerEmail': buyerEmail,
      'buyerSocialID': buyerSocialID,
      'installments': installments,
      'paymentSaleID': paymentSaleID,
      'creditCardNumber': creditCardNumber,
      'creditCardCVV': creditCardCVV,
      'creditCardExp': creditCardExp,
    };
  }
}