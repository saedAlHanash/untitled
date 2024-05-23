import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

const connectionTimeOut = Duration(seconds: 40);

final noInternet = http.Response('No Internet', 481);

final timeOut = http.Response('connectionTimeOut ', 482);
void fixQuery(Map<String, dynamic>? query) {
  query?.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  query?.forEach((key, value) => query[key] = value.toString());
}

class UploadFile {
  final Uint8List? fileBytes;
  final String nameField;
  final String? initialImage;

  UploadFile({
    this.fileBytes,
    this.initialImage,
    this.nameField = 'File',
  });

  dynamic get getImage => fileBytes ?? initialImage ?? '';

  UploadFile copyWith({
    Uint8List? fileBytes,
    String? nameField,
  }) {
    return UploadFile(
      fileBytes: fileBytes ?? this.fileBytes,
      nameField: nameField ?? this.nameField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'filelBytes': fileBytes,
      'nameField': nameField,
    };
  }

  factory UploadFile.fromMap(Map<String, dynamic> map) {
    return UploadFile(
      fileBytes: map['filelBytes'] as Uint8List,
      nameField: map['nameField'] as String,
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
