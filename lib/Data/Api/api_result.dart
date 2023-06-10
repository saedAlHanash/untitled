import 'default_response.dart';
import 'error_response.dart';

enum ApiResultType { success, failure }

abstract class ApiResult<T> {
  ApiResultType? type;
  T? data;
  String? message;
  int? numberOfPages;
  int? numberOfResults;
  int? statusCode;

  // Map<String,dynamic>? errors;

  factory ApiResult.success(T data, String message, int numberOfPages,
          int numberOfResults, int statusCode) =>
      DefaultResponse<T>(
        data: data,
        message: message,
        statusCode: statusCode,
      );

  factory ApiResult.successFromJson(Map<dynamic, dynamic> json) =>
      DefaultResponse<T>(
        data: json['data'] ?? json,
        message: json["message"],
        numberOfPages: json['number_of_pages'] ?? 0,
        numberOfResults: json['number_of_results'] ?? 0,
        status: json['statusCode'],
      );

  factory ApiResult.failure(String error) => ErrorResponse(
        message: error,
      );

  factory ApiResult.failureFromJson(Map<String, dynamic> jsonFrom,
          {int? statusCode}) =>
      ErrorResponse<T>(
        statusCode: statusCode ?? -1,
        message: jsonFrom["message"],
      );
}
