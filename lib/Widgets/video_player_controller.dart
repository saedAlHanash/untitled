import 'package:get/get.dart';

import '../Data/Repositories/get_url_video.dart';

class CustomeVideoController extends GetxController {
  String? accessToken;
  String? htmlPage;
  bool isLoading = true;
  String vimeoVideoUrl = 'https://player.vimeo.com/video/';

  @override
  Future<void> onInit() async {
    print("initial");
    await authenticateWithVimeo();
    print("end auth");
    super.onInit();
  }

  Future<void> authenticateWithVimeo() async {
    print("in authentication function");
    accessToken = await GetUrlVideo().authrizationWithVimeo();
    print("get access token");
    update();
    print("update");
  }

  changeIsLoading() {
    isLoading = !isLoading;
  }

  updateWidget() {
    update();
  }
}
