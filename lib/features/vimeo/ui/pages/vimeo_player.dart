import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../bloc/vimeo_cubit/vimeo_cubit.dart';

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
    if (videoId.isEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: MyStyle.loadingWidget(),
      );
    }
    return AppProvider.systemParams.isWebViewPlayer
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
      {super.key, required this.videoId, this.onInitController});

  final String videoId;

  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayerPod> createState() => _VimeoPlayerPodState();
}

class _VimeoPlayerPodState extends State<VimeoPlayerPod> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VimeoCubit, VimeoInitial>(
      listenWhen: (p, c) => c.controller != null,
      listener: (context, state) {
        widget.onInitController?.call(state.controller!);
      },
      builder: (context, state) {
        if (state.statuses != CubitStatuses.done) {
          return Container(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: MyStyle.loadingWidget(),
            ),
          );
        }
        loggerObject.w(state.statuses);
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PodVideoPlayer(
                controller: state.controller!,
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
      },
    );
  }
}
