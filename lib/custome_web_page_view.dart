// ignore: must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Screen/Trainee Screens/Subscription/subscription_controller.dart';

// ignore: must_be_immutable
class MyCustomeWebPage extends StatefulWidget {
  MyCustomeWebPage({super.key, this.urlWebPage, required this.subscruptionController});

  String? urlWebPage;
  late final SubscruptionController subscruptionController;

  @override
  State<MyCustomeWebPage> createState() => _MyCustomeWebPageState();
}

class _MyCustomeWebPageState extends State<MyCustomeWebPage> {
  Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    controller = Completer<WebViewController>();
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
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
        body: WebView(
          initialUrl: widget.urlWebPage,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            controller.complete(webViewController);
          },
          onProgress: (int progress) {
            //   print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            //4165 9834 2201 5610
            // todo condition should be request.url.contains('/return') ask my when work on this ??

            if (request.url == 'https://fitnessstorm.org/success.html') {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            //   print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            if (url == 'https://fitnessstorm.org/success.html') {
              Navigator.pop(context, true);
            }
            //   print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ));
  }
}
