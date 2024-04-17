import 'dart:convert';

import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../Data/Repositories/get_url_video.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';

import '../Data/Repositories/get_url_video.dart';
import '../generated/assets.dart';

class VimeoPlayer extends StatelessWidget {
  const VimeoPlayer(
      {super.key, required this.videoId, this.isPrivet = false, this.onInitController});

  final String videoId;
  final bool isPrivet;
  final Function(PodPlayerController videoController)? onInitController;

  @override
  Widget build(BuildContext context) {
    return AppProvider.systemParams.isWebViewPlayer
        ? VimeoPlayer(
            videoId: videoId,
            isPrivet: isPrivet,
            onInitController: onInitController,
          )
        : VimeoPlayerPod(
            videoId: videoId,
            isPrivet: isPrivet,
            onInitController: onInitController,
          );
  }
}

class VimeoPlayerWebView extends StatefulWidget {
  const VimeoPlayerWebView({
    super.key,
    required this.videoId,
    this.onInitController,
    this.isPrivet = false,
  });

  final String videoId;
  final bool isPrivet;
  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayerWebView> createState() => _VimeoPlayerWebViewState();
}

class _VimeoPlayerWebViewState extends State<VimeoPlayerWebView> {
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
                        url: WebUri.uri(Uri.parse(
                            'https://player.vimeo.com/video/${widget.videoId}')),
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
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    onReceivedServerTrustAuthRequest: (controller, challenge) async {
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

class VimeoPlayerPod extends StatefulWidget {
  const VimeoPlayerPod(
      {super.key, required this.videoId, this.isPrivet = false, this.onInitController});

  final String videoId;
  final bool isPrivet;
  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayerPod> createState() => _VimeoPlayerPodState();
}

class _VimeoPlayerPodState extends State<VimeoPlayerPod> {
  late PodPlayerController controller;

  Future<String> authenticateWithVimeo() async {
    return await GetUrlVideo().authrizationWithVimeo();
  }

  @override
  void initState() {
    //   print('vid: ${widget.videoId}');
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo(
        widget.videoId,
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ),
      ),
    )..initialise();

    widget.onInitController?.call(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PodVideoPlayer(
            controller: controller,
            onToggleFullScreen: (isFullScreen) async {
              if (isFullScreen) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              } else {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              }
            },
            videoThumbnail: const DecorationImage(
              image: AssetImage(Assets.imagesLogo),
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: 15.0,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  Assets.imagesFs2,
                  height: 40.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
