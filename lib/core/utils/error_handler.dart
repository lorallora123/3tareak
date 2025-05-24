import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:take_me_with_you/core/services/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unProcessableEntity,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            code: ResponseCode.success,
            message: ResponseMessage.successApi.tr());
      case DataSource.noContent:
        return Failure(
            code: ResponseCode.noContent,
            message: ResponseMessage.noContent.tr());
      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest,
            message: ResponseMessage.badRequest.tr());
      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden,
            message: ResponseMessage.forbidden.tr());
      case DataSource.unAuthorised:
        return Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized.tr());
      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound,
            message: ResponseMessage.notFound.tr());
      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError.tr());
      case DataSource.connectTimeOut:
        return Failure(
            code: ResponseCode.connectTimeOut,
            message: ResponseMessage.connectTimeOut.tr());
      case DataSource.cancel:
        return Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cancelApi.tr());
      case DataSource.receiveTimeOut:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout.tr());
      case DataSource.sendTimeOut:
        return Failure(
            code: ResponseCode.sendTimeOut,
            message: ResponseMessage.sendTimeOut.tr());
      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError,
            message: ResponseMessage.cacheError.tr());
      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnecting,
            message: ResponseMessage.noInternetConnecting.tr());
      case DataSource.unknown:
        return Failure(
            code: ResponseCode.unknown, message: ResponseMessage.unknown.tr());
      case DataSource.unProcessableEntity:
        return Failure(
            code: ResponseCode.unProcessableEntity,
            message: ResponseMessage.unProcessableEntity.tr());
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.unknown.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badResponse:
      if (error.response?.statusCode == ResponseCode.badRequest) {
        return DataSource.badRequest.getFailure();
      } else if (error.response?.statusCode == ResponseCode.forbidden) {
        return DataSource.forbidden.getFailure();
      } else if (error.response?.statusCode == ResponseCode.unauthorized) {
        return DataSource.unAuthorised.getFailure();
      } else if (error.response?.statusCode == ResponseCode.notFound) {
        return DataSource.notFound.getFailure();
      } else if (error.response?.statusCode ==
          ResponseCode.internalServerError) {
        return DataSource.internalServerError.getFailure();
      } else if (error.response?.statusCode ==
          ResponseCode.unProcessableEntity) {
        if (error.response?.data != null) {
          if (error.response?.data['message'] != null) {
            return Failure(
                code: ResponseCode.unProcessableEntity,
                message: error.response?.data['message']);
          } else {
            return DataSource.unProcessableEntity.getFailure();
          }
        } else {
          return DataSource.unProcessableEntity.getFailure();
        }
      } else {
        return DataSource.unknown.getFailure();
      }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int unProcessableEntity = 422;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnecting = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String successApi = 'successApi';
  static const String noContent = 'noContent';
  static const String badRequest = 'badRequest';
  static const String forbidden = 'forbidden';
  static const String unauthorized = 'unauthorized';
  static const String notFound = 'notFound';
  static const String unProcessableEntity = 'unProcessableEntity';
  static const String internalServerError = 'internalServerError';

  // local status code
  static const String connectTimeOut = 'connectTimeOut';
  static const String cancelApi = 'cancelApi';
  static const String receiveTimeout = 'receiveTimeout';
  static const String sendTimeOut = 'sendTimeOut';
  static const String cacheError = 'cacheError';
  static const String noInternetConnecting = 'noInternetConnecting';
  static const String unknown = 'unknown';
}

enum ApiInternalStatus {
  success,
  failure;

  @override
  String toString() => name;
}
