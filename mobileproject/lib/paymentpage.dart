import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'config.dart';
import 'payment.dart';
import 'user.dart';

class PaymentPage extends StatefulWidget {
  final User user;
  final Payment payment;
  const PaymentPage({
    Key? key,
    required this.user,
    required this.payment,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late double screenHeight, screenWidth, resWidth;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        /*child: Text(widget.payment.amount +
              " oi" +
              widget.payment.email +
              "oi " +
              widget.payment.phone),*/
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: WebView(
            initialUrl: MyConfig.server +
                '/bellacosa/php/payment_app.php?email=' +
                widget.payment.email.toString() +
                '&mobile=' +
                widget.payment.phone.toString() +
                '&name=' +
                widget.payment.name.toString() +
                '&amount=' +
                widget.payment.amount.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
          ),
        ),
      ),
    );
  }
}
