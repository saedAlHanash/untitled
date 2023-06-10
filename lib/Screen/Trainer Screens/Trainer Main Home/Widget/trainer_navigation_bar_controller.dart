import 'package:get/get.dart';

class TrainerAppNavigationBarController extends GetxController {
  final RxInt _index = 0.obs;

  int get index => _index.value;

  set index(int i) => _index.value = i;
}
