// ignore_for_file: avoid_print

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/api_manager/helpers_api/log_api.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:get/get.dart';

import 'api_result.dart';
import 'handling_errors.dart';

abstract class Methods {
  static final _dio = Get.find<Dio>();

  static Future<ApiResult> post(
      {required String url,
      required Options options,
      Map<String, dynamic>? data,
      Map<String, String>? queryParameters}) async {
    try {
      logRequest(
        url: url.replaceAll('https://api.fitnessstorm.org', ''),
        type: ApiType.post,
        q: (queryParameters ?? {})..addAll(data ?? {}),
      );
      final dio.Response response = await _dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      logResponseDio(url: url, response: response, type: ApiType.post);
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
      logRequest(
          url: url.replaceAll('https://api.fitnessstorm.org', '').replaceAll('https://api-test.fitnessstorm.org', ''),
          type: ApiType.get,
          q: data);
      var response =
          await _dio.get(url, options: options, queryParameters: data);
      logResponseDio(url: url, response: response, type: ApiType.get);
      if (response.statusCode == 200) {
        if (response.data == '' ||
            response.data is String ||
            response.data.isEmpty) {
          response.data = {};
        }
        return ApiResult.successFromJson(response.data);
      } else {
        final error = ApiResult.failureFromJson(response.data);
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




}
