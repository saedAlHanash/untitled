import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_repository.dart';
import 'package:fitness_storm/Model/private_session.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Data/Api/methods.dart';
import '../../../Data/Api/urls.dart';
import '../../../Model/chat.dart';

class TrainerWalletController extends GetxController {
  RxList<Wallet> sessions = <Wallet>[].obs;
  RxBool _isLoading = false.obs;
  RxDouble _balanced = 0.0.obs;
  Rx<RefreshController> refreshController = RefreshController().obs;
  int currentPage = 2;
  TrainerTrainerRepository _trainerRepository = TrainerTrainerRepository();

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  double get balanced => _balanced.value;

  set balanced(value) => _balanced.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    final result = await _trainerRepository.getTrainerPrivateSession(1);
    // Iterable<Wallet> inReverse = result;
    Iterable<Wallet> inReverse = result.reversed;
    sessions.addAll(inReverse);

    Options options = Utils.getOptions(accept: true, withToken: true);
    final x =  await Methods.get(url: TRAINERURLS.trainerPorile, options: options);
    balanced = x.data['wallet'];
    isLoading = false;
  }

  downloadFile(String path) async {
    Dio dio = Dio();
    await dio.download(Constants.imageUrl + path, '');
  }

  downlaodImage(String path) async {
    try {
      // Saved with this method.
      var imageId = await Image.network(Constants.imageUrl + path);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // var filePath = await ImageDownloader.findPath(imageId);
      Utils.openSnackBar(title: 'The image has been downloaded');
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      log(error.toString());
    }
  }

  onLoading() async {
    final result =
        await _trainerRepository.getTrainerPrivateSession(currentPage);
    if (result.isEmpty) {
      refreshController.value.loadNoData();
    } else {
      sessions.addAll(result);
      currentPage++;
    }
  }
}
