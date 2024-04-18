import 'package:flutter/material.dart';
import 'package:moamalat_payment/moamalat_payment.dart';

class MoamalatPay extends StatefulWidget {
   MoamalatPay({required this.amount});
    String amount;

  @override
  State<MoamalatPay> createState() => _MoamalatPayState();
}

class _MoamalatPayState extends State<MoamalatPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MoamalatPayment(
        isTest:
        true,
        merchantId: "10081014649",
        merchantReference: "PS_Merchant",
        terminalId: "99179395",
        amount:
        widget.amount,
        merchantSecretKey:
        "39636630633731362D663963322D346362642D386531662D633963303432353936373431", //put your merchantSecretKey

        onCompleteSucsses: (value) {
print(value.displayData.toString());
        },
        onError: (error) {},
      ),
    );
  }
}