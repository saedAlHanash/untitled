import 'package:bloc/bloc.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';

part 'vimeo_state.dart';

class VimeoCubit extends Cubit<VimeoInitial> {
  VimeoCubit() : super(VimeoInitial.initial());

  Future<void> initial({required String vimeoId}) async {
    return;
    if (state.result == vimeoId || AppProvider.systemParams.isWebViewPlayer)
      return;

    emit(state.copyWith(result: vimeoId, statuses: CubitStatuses.loading));

    if (state.controller != null) {
      await state.controller!.changeVideo(
        playerConfig: const PodPlayerConfig(
          wakelockEnabled: true,
          autoPlay: true,
          isLooping: true,
          videoQualityPriority: [360],
        ),
        playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
          vimeoId,
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
      );
      emit(state.copyWith(statuses: CubitStatuses.done));
      return;
    }

    final controller = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(
        wakelockEnabled: true,
        autoPlay: true,
        isLooping: true,
        videoQualityPriority: [360],
      ),
      playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
        vimeoId,
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
    );

    emit(state.copyWith(controller: controller, statuses: CubitStatuses.done));
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    return super.close();
  }
}
