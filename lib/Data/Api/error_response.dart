// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'api_result.dart';

class ErrorResponse<T> with ApiResult<T> {
  final Map<String, dynamic>? errors;
  final bool? status;
  final String? message;
  final int? statusCode;

  ErrorResponse({
    this.errors,
    this.status,
    this.message,
    this.statusCode,
  }) {
    super.type = ApiResultType.failure;
    super.message = message;
    super.statusCode = statusCode;
    //   super.errors = errors;
  }

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> jsonFrom) =>
      ErrorResponse(
        errors: jsonFrom["errors"] == null ? null : jsonFrom['errors'],
        status: jsonFrom["status"],
        message: jsonFrom["message"],
        statusCode: jsonFrom["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "status": status,
        "message": message,
        "statusCode": statusCode,
      };
}
