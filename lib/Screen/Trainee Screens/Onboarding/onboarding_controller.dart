import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'Widget/custom_container.dart';
import 'Widget/first_page.dart';
import 'Widget/fourth_page.dart';
import 'Widget/second_page.dart';
import 'Widget/third_page.dart';

class OnboardingController extends GetxController {
  final RxInt _index = 0.obs;
  final Rx<PageController> _key = PageController().obs;
  final RxList<Widget> _pages = <Widget>[].obs;
  final RxList<CustomContainer> _indicators = <CustomContainer>[].obs;
  final RxBool _isFinish = false.obs;

  int get index => _index.value;

  PageController get key => _key.value;

  List<Widget> get pages => _pages;

  List<CustomContainer> get indicators => _indicators;

  bool get isFinish => _isFinish.value;

  set index(value) => _index.value = value;

  set key(value) => _key.value = value;

  set pages(value) => _pages.value = value;

  set indicators(value) => _indicators.value = value;

  set isFinish(value) => _isFinish.value = value;

  @override
  void onInit() {
    super.onInit();
    pages = const [
      FirstPage(),
      SecondPage(),
      ThirdPage(),
      FourthPage(),
    ];
    indicators = generateContainers(Get.width / pages.length);
    indicators.removeAt(0);
    indicators.insert(
        0,
        CustomContainer(
            status: 2,
            width: MediaQuery.of(Get.context!).size.width / pages.length));
    changeIndicatorLocation(index, 0);
    update();
  }

  onSkipPages() {
    for (int i = 0; i < indicators.length; i++) {
      if (index == pages.length - 1) {
        isFinish = true;
      } else {
        isFinish = false;
      }
      index++;
      // index = pages.length - 1;
    }
  }

  onPageChanged(int newIndex) {
   //log(pages.length.toString());
   //log(newIndex.toString());
    if (newIndex == pages.length - 1) {
      isFinish = true;
    } else {
      isFinish = false;
    }
    index = newIndex;

    // changeIndicatorLocation(index, newIndex);
    update();
  }

  List<CustomContainer> generateContainers(double width) {
    List<CustomContainer> containers = [];
    for (int i = 0; i < pages.length; i++) {
      containers.add(CustomContainer(status: 0, width: width));
    }
    return containers;
  }

  void changeIndicatorLocation(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      indicators.removeAt(oldIndex);
      indicators.insert(
          oldIndex,
          CustomContainer(
              status: 2,
              width: MediaQuery.of(Get.context!).size.width / pages.length));
      indicators.removeAt(newIndex);
      indicators.insert(
          index,
          CustomContainer(
              status: 1,
              width: MediaQuery.of(Get.context!).size.width / pages.length));
    } else if (newIndex < oldIndex) {
      indicators.removeAt(newIndex);
      indicators.insert(
          index,
          CustomContainer(
              status: 1,
              width: MediaQuery.of(Get.context!).size.width / pages.length));
      indicators.removeAt(oldIndex);
      indicators.insert(
          oldIndex,
          CustomContainer(
              status: 0,
              width: MediaQuery.of(Get.context!).size.width / pages.length));
    }
  }
}
