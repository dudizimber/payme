import 'package:flutter/services.dart';

class PayMeError implements Exception {
  int errorCode;
  String errorDetails;
  String additionalInfo;
  String errorDetailsEnglish;

  PayMeError(errorCode, additionalInfo, errorDetails) {
    this.errorCode = int.tryParse(errorCode);
    if (this.errorCode == null)
      throw PlatformException(
          code: errorCode, message: additionalInfo, details: errorDetails);

    this.errorDetails = errorDetails;
    this.additionalInfo = additionalInfo;
    switch (this.errorCode) {
      case 350:
        this.errorDetailsEnglish = "Sale ID not found";
        break;
      case 305:
        this.errorDetailsEnglish = "It was not possible to complete this action due to a missmatch of sale status";
        break;
      default:
        this.errorDetailsEnglish = "Translation not found: $errorDetails";
    }
  }

  @override
  String toString() {
    return this.errorDetailsEnglish;
  }
}
