import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay extends StatefulWidget {
  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  late Razorpay _razorpay;
  TextEditingController amtController = new TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_k9VG47IWJrXPjx',
      'amount': amount,
      'name': 'E-commerce',
      'prefill': {'contact': '9354694470', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error:, e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Success" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Error" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Razor Pay Authentication'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.network(
                  "https://i.pinimg.com/600x315/e8/9f/67/e89f67159c53c13538674668b9952d9b.jpg"),
              SizedBox(
                height: 40,
              ),
              Text("Welcome to RazorPay Payment Gateway"),
              TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                decoration:
                    InputDecoration(labelText: "Enter amount to be paid"),
                controller: amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter amount to be paid";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (amtController.text.toString().isNotEmpty) {
                      setState(() {
                        int amount =
                            int.parse(amtController.text.toString().trim());
                        openCheckout(amount);
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Make Payment'),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
