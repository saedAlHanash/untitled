// ignore_for_file: avoid_print

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:get/get.dart';

import 'api_result.dart';
import 'handling_errors.dart';

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
        return ApiResult.failureFromJson(response.data,
            statusCode: response.statusCode);
      }
    } catch (e) {
      loggerObject.e(e);

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
      var response =
          await _dio.get(url, options: options, queryParameters: data);
      if (response.statusCode == 200) {
        if (response.data == '' ||
            response.data is String ||
            response.data.isEmpty) {
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
      loggerObject.e(e);

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
      loggerObject.e(e);
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
      loggerObject.e(e);

      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<ApiResult> delete(
      {required String url, required Options options, data}) async {
    try {
      var response = await _dio.delete(url, options: options, data: data);
      //   print('response ${url.split('').last}: ${response.data}');
      if (response.statusCode == 200) {
        return ApiResult.successFromJson(response.data);
      } else {
        return ApiResult.failureFromJson(response.data);
      }
    } catch (e) {
      loggerObject.e(e);

      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  static Future<void> download(
      {required String url, required String dir}) async {
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
      loggerObject.e(e);
    }
  }
}
