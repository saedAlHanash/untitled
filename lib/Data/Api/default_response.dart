// ignore_for_file: annotate_overrides, overridden_fields

import 'api_result.dart';

class DefaultResponse<T> extends ApiResult<T> {
  DefaultResponse({
    this.data,
    this.status,
    this.statusCode,
    this.message,
    this.numberOfPages,
    this.numberOfResults,
  }) : super(null, null, '', 0, 0, 0) {
    super.type = ApiResultType.success;
    super.data = data;
    super.statusCode = statusCode;
    super.message = message;
    super.numberOfPages = numberOfPages;
    super.numberOfResults = numberOfResults;
  }

  final T? data;
  final bool? status;
  final int? statusCode;
  final String? message;
  final int? numberOfPages;
  final int? numberOfResults;
}
