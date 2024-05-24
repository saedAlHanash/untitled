import 'dart:async';
import 'dart:convert';

import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../services/server_time_service.dart';
import '../injection/injection_container.dart';
import '../network/network_info.dart';
import 'api_helper.dart';
import 'api_url.dart';

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

class APIService {
  static final APIService _singleton = APIService._internal();

  final network = sl<NetworkInfo>();

  factory APIService() => _singleton;

  Map<String, String> get innerHeader => {
        'Content-Type': 'application/json',
        'Accept': 'Application/json',
        'timeZone': DateTime.now().timeZoneName,
        'lang': Get.locale?.languageCode ?? 'en',
        'Authorization': 'Bearer ${AppProvider.token}',
      };

  APIService._internal();

  Future<http.Response> getApi({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? path,
    String? additionalConstParam,
  }) async {
    if (!await network.isConnected) noInternet;

    url = (additionalConstParam ?? additionalConst) + url;

    fixQuery(query);

    if (path != null) url = '$url/$path';

    var uri = Uri.https(baseUrl, url, query);

    logRequest(url, query);

    final response = await http
        .get(uri, headers: innerHeader..addAll(headers ?? {}))
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> getApiFromUrl({
    required String url,
  }) async {
    if (!await network.isConnected) noInternet;
    url = additionalConst + url;
    var uri = Uri.parse(url);

    logRequest(url, null);

    final response = await http
        .get(uri, headers: innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    logResponse(url, response);
    return response;
  }

  Future<http.Response> postApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? additional,
  }) async {
    if (!await network.isConnected) noInternet;

    url = (additional ?? additionalConst) + url;

    body?.removeWhere(
        (key, value) => (value == null || value.toString().isEmpty));

    fixQuery(query);

    if (path != null) url = '$url/$path';

    final uri = Uri.https(baseUrl, url, query);

    logRequest(
        url,
        {}
          ..addAll(query ?? {})
          ..addAll(body ?? {}));

    final response = await http
        .post(uri, body: jsonEncode(body), headers: header ?? innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> patchApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? additional,
  }) async {
    if (!await network.isConnected) noInternet;
    url = (additional ?? additionalConst) + url;

    innerHeader.addAll(header ?? {});
    body?.removeWhere(
        (key, value) => (value == null || value.toString().isEmpty));

    fixQuery(query);

    if (path != null) url = '$url/$path';

    final uri = Uri.https(baseUrl, url, query);

    logRequest(
        url,
        {}
          ..addAll(query ?? {})
          ..addAll(body ?? {}));

    final response = await http
        .patch(uri, body: jsonEncode(body), headers: innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> puttApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String? path,
  }) async {
    if (!await network.isConnected) noInternet;
    url = additionalConst + url;
    body?.removeWhere(
        (key, value) => (value == null || value.toString().isEmpty));

    fixQuery(query);
    if (path != null) url = '$url/$path';
    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response = await http
        .put(uri, body: jsonEncode(body), headers: innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> patch({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String? path,
  }) async {
    if (!await network.isConnected) noInternet;
    url = additionalConst + url;
    body?.removeWhere(
        (key, value) => (value == null || value.toString().isEmpty));

    fixQuery(query);
    if (path != null) url = '$url/$path';
    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response = await http
        .patch(uri, body: jsonEncode(body), headers: innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> deleteApi({
    required String url,
    String? path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    if (!await network.isConnected) noInternet;
    url = additionalConst + url;

    body?.removeWhere(
        (key, value) => (value == null || value.toString().isEmpty));

    fixQuery(query);

    if (path != null) url = '$url/$path';

    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response = await http
        .delete(uri, body: jsonEncode(body), headers: innerHeader)
        .timeout(connectionTimeOut, onTimeout: () => timeOut);

    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  Future<http.Response> uploadMultiPart({
    required String url,
    String? path,
    String? additional,
    String type = 'POST',
    List<UploadFile?>? files,
    Map<String, dynamic>? fields,
    Map<String, String>? header,
  }) async {
    Map<String, String> f = {};
    (fields ?? {}).forEach((key, value) => f[key] = value.toString());

    innerHeader.addAll(header ?? {});
    url = (additional ?? additionalConst) + url;
    final uri = Uri.https(baseUrl, '$url${path != null ? '/$path' : ''}');

    var request = http.MultipartRequest(type, uri);

    ///log
    logRequest(url, fields, additional: files?.firstOrNull?.nameField);

    for (var uploadFile in (files ?? <UploadFile?>[])) {
      if (uploadFile?.fileBytes == null) continue;

      final multipartFile = http.MultipartFile.fromBytes(
        uploadFile!.nameField,
        uploadFile.fileBytes!,
        filename: '${getRandomString(10)}.jpg',
      );

      request.files.add(multipartFile);
    }

    request.followRedirects = true;
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(innerHeader);
    request.fields.addAll(f);

    final stream = await request.send().timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.StreamedResponse(Stream.value([]), 481),
        );

    final response = await http.Response.fromStream(stream);

    ///log
    logResponse(url, response);

    if (response.statusCode.success) ServerTimeService.setServerDate = response;
    return response;
  }

  void logRequest(String url, Map<String, dynamic>? q, {String? additional}) {
    var msg = url;
    if (q != null) msg += '\n ${jsonEncode(q)}';
    if (additional != null) msg += '\n $additional';

    loggerObject.i(msg);
  }

  void logResponse(String url, http.Response response) {
    var r = [];
    var res = '';
    if (response.body.length > 800) {
      r = response.body.splitByLength1(800);
      for (var e in r) {
        res += '$e\n';
      }
    } else {
      res = response.body;
    }

    loggerObject.t('${response.statusCode} \n $res');
  }
}
