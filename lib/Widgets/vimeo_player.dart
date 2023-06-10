import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../Data/Repositories/get_url_video.dart';

// ignore: must_be_immutable
class VimoePlayer extends StatefulWidget {
  VimoePlayer({super.key, required this.videoId});

  final String videoId;

  @override
  State<VimoePlayer> createState() => _VimoePlayerState();
}

class _VimoePlayerState extends State<VimoePlayer> {
  InAppWebViewController? webView;
  String? accessToken;
  String? htmlPage;
  bool isLoading = true;
  double progress = 0;

  Future<void> authenticateWithVimeo() async {
    print("in authentication function");
    accessToken = await GetUrlVideo().authrizationWithVimeo();
    print("get access token");
    setState(() {});
    print("update");
  }

  @override
  void initState() {
    authenticateWithVimeo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        progress < 1.0
            ? Container(
                padding: const EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : const SizedBox.shrink())
            : const SizedBox.shrink(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.283,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: accessToken == null
                ? const CircularProgressIndicator()
                : InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            'https://player.vimeo.com/video/${widget.videoId}'),
                        headers: {
                          'Authorization':
                              'Basic ${base64Encode(utf8.encode('9353127f0c5d3848970ed83590f3989b7d4aeabf:lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw'))}',
                          'Content-Type': 'application/json',
                          'Accept': "application/vnd.vimeo.*+json;version=3.4",
                        }),
                    onWebViewCreated: (controller) {
                      webView = controller;
                    },
                    onLoadStop: (controller1, url) {},
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onReceivedServerTrustAuthRequest:
                        (controller, challenge) async {
                      return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED);
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                        allowsAirPlayForMediaPlayback: false,
                        scrollsToTop: false,
                      ),
                    ),
                    onEnterFullscreen: (controller) async {
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft,
                      ]);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
