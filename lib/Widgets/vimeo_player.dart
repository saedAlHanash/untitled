import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pod_player/pod_player.dart';

import '../core/util/my_style.dart';
import '../generated/assets.dart';

class VimeoPlayer extends StatelessWidget {
  const VimeoPlayer(
      {super.key,
      required this.videoId,
      this.isPrivet = false,
      this.onInitController});

  final String videoId;
  final bool isPrivet;
  final Function(PodPlayerController videoController)? onInitController;

  @override
  Widget build(BuildContext context) {
    return !AppProvider.systemParams.isWebViewPlayer
        ? VimeoPlayerWebView(
            videoId: videoId,
            onInitController: onInitController,
          )
        : VimeoPlayerPod(
            videoId: videoId,
            onInitController: onInitController,
          );
  }
}

class VimeoPlayerWebView extends StatefulWidget {
  const VimeoPlayerWebView({
    super.key,
    required this.videoId,
    this.onInitController,

  });

  final String videoId;

  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayerWebView> createState() => _VimeoPlayerWebViewState();
}

class _VimeoPlayerWebViewState extends State<VimeoPlayerWebView> {
  InAppWebViewController? webView;
  String accessToken = '';
  String? htmlPage;
  bool isLoading = true;
  double progress = 0;

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
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse('https://player.vimeo.com/video/${widget.videoId}'),
                ),
              ),
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
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              // initialOptions: InAppWebViewGroupOptions(
              //   android: AndroidInAppWebViewOptions(
              //     useHybridComposition: true,
              //   ),
              //   ios: IOSInAppWebViewOptions(
              //     allowsInlineMediaPlayback: true,
              //     allowsAirPlayForMediaPlayback: false,
              //     scrollsToTop: false,
              //   ),
              // ),
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
      {super.key,
      required this.videoId,

      this.onInitController});

  final String videoId;

  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayerPod> createState() => _VimeoPlayerPodState();
}

class _VimeoPlayerPodState extends State<VimeoPlayerPod> {
  late PodPlayerController controller;

  bool isInitial = false;
  late final VideoPlayerController vc;

  @override
  void initState() {
    // vc = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://player.vimeo.com/progressive_redirect/playback/739932290/rendition/540p/file.mp4?loc=external&oauth2_token_id=1770106234&signature=e1c48a7068bd338603c6c0213099b6258fc6dd04396674ec08ea3dc7ff99c725'));
    // vc.initialize().then(
    //   (value) {
    //
    //     setState(() {
    //       isInitial = true;
    //     });
    //
    //     vc.play();
    //   },
    // );
    controller = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(
        wakelockEnabled: true,
        autoPlay: true,
        isLooping: true,
        videoQualityPriority: [360],
      ),
      playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
        widget.videoId,
        httpHeaders: {
          'Authorization': 'Bearer 021e33294bd3accb2c957b2a406b6c30',
          'Content-Type': 'application/json',
          'Accept': "application/vnd.vimeo.*+json;version=3.4",
        },
        // '784930773',
        // httpHeaders: {'Authorization': 'Bearer $token'},
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ),
      ),
    )..initialise().then((value) {
      if(!mounted)return;
        setState(() {});
      });

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
          if (false)
            isInitial
                ? Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(vc),
                    ),
                  )
                : MyStyle.loadingWidget()
          else
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
