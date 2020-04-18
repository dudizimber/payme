class PaySaleResponse {
  String paymeStatus;
  String paymeSaleId;
  String saleCreated;
  String paymeSaleStatus;
  String saleStatus;
  String currency;
  String transactionId;
  String paymeSignature;
  String paymeTransactionId;
  String paymeTransactionTotal;
  String paymeTransactionCardBrand;
  String paymeTransactionAuthNumber;
  String buyerName;
  String buyerEmail;
  String buyerPhone;
  String buyerCardMask;
  String buyerCardExp;
  String buyerSocialId;
  String salePaidDate;
  String saleReleaseDate;
  int statusCode;
  int installments;
  int price;
  int paymeSaleCode;
  bool isTokenSale;

  PaySaleResponse({
    this.buyerCardExp,
    this.buyerCardMask,
    this.buyerEmail,
    this.buyerName,
    this.buyerPhone,
    this.buyerSocialId,
    this.currency,
    this.installments,
    this.isTokenSale,
    this.paymeSaleCode,
    this.paymeSaleId,
    this.paymeSaleStatus,
    this.paymeSignature,
    this.paymeStatus,
    this.paymeTransactionAuthNumber,
    this.paymeTransactionCardBrand,
    this.paymeTransactionId,
    this.paymeTransactionTotal,
    this.price,
    this.saleCreated,
    this.salePaidDate,
    this.saleReleaseDate,
    this.saleStatus,
    this.statusCode,
    this.transactionId,
  });

  factory PaySaleResponse.fromMethod(Map object) {
    return PaySaleResponse(
      buyerCardExp:
          object.containsKey('buyerCardExp') ? object['buyerCardExp'].toString() : null,
      buyerCardMask:
          object.containsKey('buyerCardMask') ? object['buyerCardMask'].toString() : null,
      buyerEmail:
          object.containsKey('buyerEmail') ? object['buyerEmail'].toString() : null,
      buyerName: object.containsKey('buyerName') ? object['buyerName'].toString() : null,
      buyerPhone:
          object.containsKey('buyerPhone') ? object['buyerPhone'].toString() : null,
      buyerSocialId:
          object.containsKey('buyerSocialId') ? object['buyerSocialId'].toString() : null,
      currency: object.containsKey('currency') ? object['currency'].toString() : null,
      installments:
          object.containsKey('installments') ? object['installments'] : null,
      isTokenSale:
          object.containsKey('isTokenSale') ? object['isTokenSale'] : null,
      paymeSaleCode:
          object.containsKey('paymeSaleCode') ? object['paymeSaleCode'] : null,
      paymeSaleId:
          object.containsKey('paymeSaleId') ? object['paymeSaleId'].toString() : null,
      paymeSaleStatus: object.containsKey('paymeSaleStatus')
          ? object['paymeSaleStatus'].toString()
          : null,
      paymeSignature: object.containsKey('paymeSignature')
          ? object['paymeSignature'].toString()
          : null,
      paymeStatus:
          object.containsKey('paymeStatus') ? object['paymeStatus'].toString() : null,
      paymeTransactionAuthNumber:
          object.containsKey('paymeTransactionAuthNumber')
              ? object['paymeTransactionAuthNumber'].toString()
              : null,
      paymeTransactionCardBrand: object.containsKey('paymeTransactionCardBrand')
          ? object['paymeTransactionCardBrand'].toString()
          : null,
      paymeTransactionId: object.containsKey('paymeTransactionId')
          ? object['paymeTransactionId'].toString()
          : null,
      paymeTransactionTotal: object.containsKey('paymeTransactionTotal')
          ? object['paymeTransactionTotal'].toString()
          : null,
      price: object.containsKey('price') ? object['price'] : null,
      saleCreated:
          object.containsKey('saleCreated') ? object['saleCreated'].toString() : null,
      salePaidDate:
          object.containsKey('salePaidDate') ? object['salePaidDate'].toString() : null,
      saleReleaseDate: object.containsKey('saleReleaseDate')
          ? object['saleReleaseDate'].toString()
          : null,
      saleStatus:
          object.containsKey('saleStatus') ? object['saleStatus'].toString() : null,
      statusCode:
          object.containsKey('statusCode') ? object['statusCode'] : null,
      transactionId:
          object.containsKey('transactionId') ? object['transactionId'].toString() : null,
    );
  }
}
