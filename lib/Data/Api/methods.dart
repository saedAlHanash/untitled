// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../helper/loging_service.dart';
import 'api_result.dart';
import 'handling_errors.dart';

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

abstract class Methods {
  static final _dio = Get.find<Dio>();

  static Future<ApiResult> post(
      {required String url,
      required Options options,
      data,
      Map<String, String>? queryParameters}) async {
    try {
      final dio.Response response = await _dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 500) {
        return ApiResult.failureFromJson(response.data);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.successFromJson(response.data);
      } else {
        return ApiResult.failureFromJson(response.data, statusCode: response.statusCode);
      }
    } catch (e) {
      LogService().e(e.toString());
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<ApiResult> get({
    required String url,
    required Options options,
    Map<String, dynamic>? data,
    bool? isNotification,
  }) async {
    try {
      var response = await _dio.get(url, options: options, queryParameters: data);
      if (response.statusCode == 200) {
        if (response.data == '' || response.data is String || response.data.isEmpty) {
          response.data = {};
        }
        return ApiResult.successFromJson(response.data);
      } else {
        final error = ApiResult.failureFromJson(response.data);
        // if (error.message?.contains('Account is not confirmed') ?? false) {
        //   StorageController().token = '';
        //   Get.offAllNamed(AppRoutes.signIn, arguments: ['', false]);
        // }
        return error;
      }
    } catch (e) {
      LogService().e(e.toString());
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<dio.Response?> getJson({
    required String url,
    required Options options,
    Map<String, dynamic>? data,
    bool? isNotification,
  }) async {
    try {
      return await _dio.get(url, options: options, queryParameters: data);
    } catch (e) {
      return null;
    }
  }

  static Future<ApiResult> put(
      {required String url, required Options options, data}) async {
    try {
      var response = await _dio.put(url, options: options, data: data);
      //   print('response ${url.split('').last}: ${response.data}');
      if (response.statusCode == 200) {
        return ApiResult.successFromJson(response.data);
      } else {
        return ApiResult.failureFromJson(response.data);
      }
    } catch (e) {
      LogService().e(e.toString());
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<ApiResult> delete(
      {required String url, required Options options, data}) async {
    LogService().wtf(url);
    try {
      var response = await _dio.delete(url, options: options, data: data);
      //   print('response ${url.split('').last}: ${response.data}');
      if (response.statusCode == 200) {
        return ApiResult.successFromJson(response.data);
      } else {
        return ApiResult.failureFromJson(response.data);
      }
    } catch (e) {
      LogService().e(e.toString());
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<void> download({required String url, required String dir}) async {
    LogService().wtf(url);
    LogService().wtf(dir);
    //   print(url);
    //   print(dir);
    // dir = dir[1];
    try {
      //   print('uuuuuuuuuuuuu $url');
      //   print('ddddddddddddd $dir');
      await _dio.download(url, dir, onReceiveProgress: (rec, total) {
        //   print("Rec: $rec , Total: $total");
      });
    } catch (e) {
      LogService().e(e.toString());
    }
  }
}
