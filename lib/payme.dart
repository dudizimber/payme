import 'dart:async';

import 'package:flutter/services.dart';
import 'package:payme/models/Environments.dart';
import 'package:payme/models/PayMeError.dart';
import 'package:payme/models/PaySaleRequest.dart';
import 'package:payme/models/PaySaleResponse.dart';

export 'models/PaySaleRequest.dart';
export 'models/PaySaleResponse.dart';
export 'models/Environments.dart';

class Payme {
  static const MethodChannel _channel = const MethodChannel('payme');

  static Future<bool> init(String sellerKey, Environments environment) async {
    try {
      await _channel.invokeMethod('init', <String, dynamic>{
        'sellerKey': sellerKey,
        'environment':
            environment == Environments.PRODUCTION ? 'PRODUCTION' : 'STAGING'
      });
      return true;
    } catch (e) {
      throw PayMeError(e.errorCode, e.errorMessage, e.errorDetails);
    }
  }

  static Future<PaySaleResponse> paySale(PaySaleRequest paySaleRequest) async {
    dynamic response;
    try {
      response = await _channel.invokeMethod('paySale', <String, dynamic>{
        'paySaleRequest': paySaleRequest.toMap(),
      });
    } catch (e) {
      print('Pure Error: $e');
      throw PayMeError(e.code, e.message, e.details);
    }
    print('Pure Response: $response');
    PaySaleResponse paySaleResponse = PaySaleResponse.fromMethod(response);
    return paySaleResponse;
  }
}
