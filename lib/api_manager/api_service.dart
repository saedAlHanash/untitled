import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'enum_manager.dart';
import 'helpers_api/helper_api_service.dart';
import 'helpers_api/log_api.dart';

var loggerObject = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    // number of method calls to be displayed
    errorMethodCount: 0,
    // number of method calls if stacktrace is provided
    lineLength: 300,
    // width of the output
    colors: true,
    // Colorful log messages
    printEmojis: false,
    // Print an emoji for each log message
    printTime: false,
  ),
);

Map<String, String> get innerHeader => {
      'Content-Type': 'application/json',
      'Accept': 'Application/json',
      'timeZone': DateTime.now().timeZoneName,
      'lang': Get.locale?.languageCode ?? 'en',
    };

class APIService {
  static final APIService _singleton = APIService._internal();

  APIService._internal();

  factory APIService() => _singleton;



  Future<http.Response> callApi({
    required String url,
    required ApiType type,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? additional,
    String? hostName,
  }) async {

    final uri = getUri(
        additional: additional??'' ,
        url: url,
        query: query,
        path: path,
        body: body,
        type: type);

    try {
      late final http.Response response;

      switch (type) {
        case ApiType.get:
          response = await http
              .get(uri, headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
          break;
        case ApiType.post:
          response = await http
              .post(uri,
                  body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
          break;
        case ApiType.put:
          response = await http
              .put(uri,
                  body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
          break;
        case ApiType.patch:
          response = await http
              .patch(uri,
                  body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
          break;
        case ApiType.delete:
          response = await http
              .delete(uri,
                  body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
          break;
      }

      logResponse(url: url, response: response, type: type);

      return response;
    } catch (e) {
      loggerObject.e(e);
      return noInternet;
    }
  }

  Future<http.Response> uploadMultiPart({
    required String url,
    String? path,
    String? additional,
    String type = 'POST',
    List<UploadFile?>? files,
    Map<String, dynamic>? fields,
  }) async {
    final uri = getUri(
      additional: additional ?? '',
      url: url,
      query: fields,
      path: path,
      type: ApiType.post,
    );

    var request = http.MultipartRequest(type, uri);

    for (var uploadFile in (files ?? <UploadFile?>[])) {
      if (uploadFile?.fileBytes == null) continue;

      final multipartFile = http.MultipartFile.fromBytes(
        uploadFile!.nameField,
        uploadFile.fileBytes!,
        filename: '${getRandomString(10)}.jpg',
      );

      request.files.add(multipartFile);
    }

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(innerHeader);
    request.fields.addAll(fixFields(fields));

    final stream = await request.send().timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.StreamedResponse(Stream.value([]), 481),
        );

    final response = await http.Response.fromStream(stream);

    logResponse(url: url, response: response, type: ApiType.post);

    return response;
  }
}

class UploadFile {
  Uint8List? fileBytes;
  String nameField;
  String? initialImage;
  String? assetImage;

  UploadFile({
    this.fileBytes,
    this.initialImage,
    this.nameField = 'File',
    this.assetImage = '',
  });

  dynamic get getImage => fileBytes ?? initialImage ?? assetImage;

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
