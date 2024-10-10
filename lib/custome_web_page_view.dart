import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyCustomWebPage extends StatefulWidget {
  const MyCustomWebPage({super.key, this.urlWebPage});

  final String? urlWebPage;

  @override
  State<MyCustomWebPage> createState() => _MyCustomWebPageState();
}

class _MyCustomWebPageState extends State<MyCustomWebPage> {
  Completer<WebViewController> controller = Completer<WebViewController>();
  InAppWebViewController? webView;

  @override
  void initState() {
    super.initState();

    controller = Completer<WebViewController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Get.back();
            // await Get.find<SubscruptionController>().getSubscribtionPaymentPlan();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'subscription_payment'.tr,
        ),
      ),
      body: Column(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(widget.urlWebPage ?? '')),
            ),
            onWebViewCreated: (controller) {
              webView = controller;
            },
            onLoadStop: (controller1, url) {
              if (url?.uriValue.toString() == 'https://fitnessstorm.org/success.html') {
                Navigator.pop(context, true);
              }
            },
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED);
            },
          ),
        ],
      ),
    );
  }
}
