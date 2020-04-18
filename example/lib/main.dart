import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:payme/payme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PaySaleResponse _paySaleResponse;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      const SELLER_KEY = "MPL15050-31782VOG-PUGRPVZO-3FVHWEYD";
      const SELLER_KEY_DUDI = "MPL15870-51134L1C-QSTQJXYL-XSL8KZME";
      await Payme.init(SELLER_KEY, Environments.STAGING);
    } catch (e) {
      print('Error: $e');
    }

    PaySaleResponse paySaleResponse = PaySaleResponse();

    try {
      paySaleResponse = await Payme.paySale(PaySaleRequest.def('SALE1587-235002MC-LOFTL1YX-MFTKVJ4C'));
    } catch(e) {
      print('Error: ${e.toString()}');
    }

    if (!mounted) return;

    setState(() {
      _paySaleResponse = paySaleResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: ${_paySaleResponse == null ? 'NULL' : _paySaleResponse.transactionId ?? 'NULL'}\n'),
        ),
      ),
    );
  }
}
