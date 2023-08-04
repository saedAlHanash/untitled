import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';

import '../Data/Repositories/get_url_video.dart';
import '../generated/assets.dart';

class VimeoPlayer extends StatefulWidget {
  const VimeoPlayer(
      {super.key, required this.videoId, this.isPrivet = false, this.onInitController});

  final String videoId;
  final bool isPrivet;
  final Function(PodPlayerController videoController)? onInitController;

  @override
  State<VimeoPlayer> createState() => _VimeoPlayerState();
}

class _VimeoPlayerState extends State<VimeoPlayer> {
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
              image: AssetImage(Assets.imagesLogo2),
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
