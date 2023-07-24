import 'package:flutter/material.dart';
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
    print('vid: ${widget.videoId}');
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
      child: PodVideoPlayer(
        controller: controller,
        videoThumbnail: const DecorationImage(
          image: AssetImage(Assets.imagesLogo2),
        ),
        videoTitle: Row(
          children: [
            Image.asset(
              Assets.imagesLogoLight,
              height: 40.0,
              width: 40.0,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
