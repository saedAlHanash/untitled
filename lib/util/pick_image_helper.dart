import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PickImageHelper {
  static final PickImageHelper _singleton = PickImageHelper._internal();

  factory PickImageHelper() {
    return _singleton;
  }

  PickImageHelper._internal();

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage() async {
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    return result;
  }

  Future<Uint8List?> pickImageBytes() async {
    final result = await pickImage();

    return result?.readAsBytes();
  }

// // Pick an image
// final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// // Capture a photo
// final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
// // Pick a video
// final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
// // Capture a video
// final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
// // Pick multiple images
// final List<XFile>? images = await _picker.pickMultiImage();
}
