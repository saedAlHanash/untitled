import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

enum NetworkException {
  requestCancelled,
  unauthorisedRequest,
  badRequest,
  notFound,
  methodNotAllowed,
  notAcceptable,
  requestTimeout,
  sendTimeout,
  conflict,
  internalServerError,
  notImplemented,
  serviceUnavailable,
  noInternetConnection,
  formatException,
  unableToProcess,
  defaultError,
  unexpectedError,
}

class NetworkExceptions {
  final NetworkException networkException;
  final String? error;

  NetworkExceptions(this.networkException, {this.error});

  factory NetworkExceptions.requestCancelled() =>
      NetworkExceptions(NetworkException.requestCancelled);

  factory NetworkExceptions.unauthorisedRequest() =>
      NetworkExceptions(NetworkException.unauthorisedRequest);

  factory NetworkExceptions.badRequest() =>
      NetworkExceptions(NetworkException.badRequest);

  factory NetworkExceptions.notFound(String error) =>
      NetworkExceptions(NetworkException.notFound, error: error);

  factory NetworkExceptions.methodNotAllowed() =>
      NetworkExceptions(NetworkException.methodNotAllowed);

  factory NetworkExceptions.notAcceptable() =>
      NetworkExceptions(NetworkException.notAcceptable);

  factory NetworkExceptions.requestTimeout() =>
      NetworkExceptions(NetworkException.requestTimeout);

  factory NetworkExceptions.sendTimeout() =>
      NetworkExceptions(NetworkException.sendTimeout);

  factory NetworkExceptions.conflict() =>
      NetworkExceptions(NetworkException.conflict);

  factory NetworkExceptions.internalServerError() =>
      NetworkExceptions(NetworkException.internalServerError);

  factory NetworkExceptions.notImplemented() =>
      NetworkExceptions(NetworkException.notImplemented);

  factory NetworkExceptions.serviceUnavailable() =>
      NetworkExceptions(NetworkException.serviceUnavailable);

  factory NetworkExceptions.noInternetConnection() =>
      NetworkExceptions(NetworkException.noInternetConnection);

  factory NetworkExceptions.formatException() =>
      NetworkExceptions(NetworkException.formatException);

  factory NetworkExceptions.unableToProcess() =>
      NetworkExceptions(NetworkException.unableToProcess);

  factory NetworkExceptions.unexpectedError() =>
      NetworkExceptions(NetworkException.unexpectedError);

  factory NetworkExceptions.defaultError(String error) =>
      NetworkExceptions(NetworkException.defaultError, error: error);

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions = NetworkExceptions.badRequest();
        if (error is dio.DioError) {
          switch (error.type) {
            case dio.DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            // case dio.DioErrorType.connectTimeout:
            //   networkExceptions = NetworkExceptions.requestTimeout();
            //   break;
            // case dio.DioErrorType.other:
            //   networkExceptions = NetworkExceptions.noInternetConnection();
            //   break;
            // case dio.DioErrorType.receiveTimeout:
            //   networkExceptions = NetworkExceptions.sendTimeout();
            //   break;
            // case dio.DioErrorType.response:
            //   switch (error.response!.statusCode!) {
            //     case 400:
            //       networkExceptions = NetworkExceptions.unauthorisedRequest();
            //       break;
            //     case 401:
            //       networkExceptions = NetworkExceptions.unauthorisedRequest();
            //       break;
            //     case 403:
            //       networkExceptions = NetworkExceptions.unauthorisedRequest();
            //       break;
            //     case 404:
            //       networkExceptions = NetworkExceptions.notFound("Not found");
            //       break;
            //     case 409:
            //       networkExceptions = NetworkExceptions.conflict();
            //       break;
            //     case 408:
            //       networkExceptions = NetworkExceptions.requestTimeout();
            //       break;
            //     case 500:
            //       networkExceptions = NetworkExceptions.internalServerError();
            //       break;
            //     case 503:
            //       networkExceptions = NetworkExceptions.serviceUnavailable();
            //       break;
            //     default:
            //       var responseCode = error.response!.statusCode;
            //       networkExceptions = NetworkExceptions.defaultError(
            //         "Received invalid status code: $responseCode",
            //       );
            //   }

            case dio.DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case dio.DioErrorType.connectionTimeout:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.sendTimeout:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.receiveTimeout:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.badCertificate:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.badResponse:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.cancel:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.connectionError:
              // TODO: Handle this case.
              break;
            case dio.DioErrorType.unknown:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(error) {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(error);
    return _getMessage(networkException).tr;
  }

  static String _getMessage(NetworkExceptions networkException) {
    var errorMessage = "";
    switch (networkException.networkException) {
      case NetworkException.notImplemented:
        errorMessage = "Not_Implemented".tr;
        break;
      case NetworkException.requestCancelled:
        errorMessage = "Request_Cancelled".tr;
        break;
      case NetworkException.internalServerError:
        errorMessage = "Internal_Server_Error".tr;
        break;
      case NetworkException.serviceUnavailable:
        errorMessage = "Service_unavailable".tr;
        break;
      case NetworkException.methodNotAllowed:
        errorMessage = "Method_Allowed".tr;
        break;
      case NetworkException.badRequest:
        errorMessage = "Bad_request".tr;
        break;
      case NetworkException.unauthorisedRequest:
        errorMessage = "Unauthorised_request".tr;
        break;
      case NetworkException.unexpectedError:
        errorMessage = "Unexpected_error_occurred".tr;
        break;
      case NetworkException.requestTimeout:
        errorMessage = "Connection_request_timeout".tr;
        break;
      case NetworkException.noInternetConnection:
        errorMessage = "No_internet_connection".tr;
        break;
      case NetworkException.conflict:
        errorMessage = "Error_due_to_a_conflict".tr;
        break;
      case NetworkException.sendTimeout:
        errorMessage = "Send_timeoutin_connection_withAPIserver".tr;
        break;
      case NetworkException.unableToProcess:
        errorMessage = "Unable_to_process_thedata".tr;
        break;

      case NetworkException.formatException:
        errorMessage = "Unexpected_error_occurred".tr;
        break;

      case NetworkException.notAcceptable:
        errorMessage = "Not_acceptable".tr;
        break;
      case NetworkException.defaultError:
        errorMessage = "networkException.error!";
        break;
      case NetworkException.notFound:
        errorMessage = 'networkException.notfound';
        break;
    }
    return errorMessage;
  }
}
