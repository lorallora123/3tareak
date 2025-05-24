import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:take_me_with_you/core/services/failure.dart';
import 'package:take_me_with_you/core/utils/end_points.dart';
import 'package:take_me_with_you/core/utils/error_handler.dart';
import 'package:take_me_with_you/core/utils/function.dart';

class DataService {
  final Dio _dio;

  DataService(this._dio);

  Future<Either<Failure, T>> getData<T>({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required fromJson,
    required Function(Object? json) fromJsonData,
  }) async {
    try {
      if (await noInternetConnection()) {
        return Left(DataSource.noInternetConnection.getFailure());
      }
      final response = await _dio.get(
        EndPoints.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: options(),
      );
      final value = fromJson(response.data!, fromJsonData);

      if (value.status.toString() == ApiInternalStatus.success.toString() ||
          response.statusCode == 200) {
        return Right(value.data ?? response);
      } else {
        return Left(
            Failure(code: ResponseCode.success, message: value.message!));
      }
    } catch (error) {
      logPrint(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, T>> postData<T>({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required fromJson,
    Function(Object? json)? fromJsonData,
    bool isPut = false,
  }) async {
    try {
      if (await noInternetConnection()) {
        return Left(DataSource.noInternetConnection.getFailure());
      }
      final response = isPut
          ? await _dio.put(
              EndPoints.baseUrl + endPoint,
              queryParameters: queryParameters,
              data: data == null ? null : FormData.fromMap(data),
              options: options(),
            )
          : await _dio.post(
              EndPoints.baseUrl + endPoint,
              queryParameters: queryParameters,
              data: data == null ? null : FormData.fromMap(data),
              options: options(),
            );
      final value = fromJson(response.data!, fromJsonData);

      if (value.status.toString() == ApiInternalStatus.success.toString()) {
        return Right(value.data ?? value);
      } else {
        return Left(
            Failure(code: ResponseCode.success, message: value.message!));
      }
    } catch (error) {
      logPrint(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, dynamic>> sendRequest({
    bool isGet = true,
    required String url,
    bool withAuthentication = false,
    var data,
  }) async {
    Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          'timeZone': 'utc'
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        });
    Response? response;
    try {
      if (isGet) {
        response = await _dio.get(url, queryParameters: data, options: options);
      } else {
        response = await _dio.post(url, data: data, options: options);
      }
      var decoded =
          response.data is String ? json.decode(response.data) : response.data;
      if (response.statusCode == 200) {
        return Right(decoded);
      } else {
        return Left(DataSource.badRequest.getFailure());
      }
    } catch (e) {
      logPrint(e.toString());
      return Left(DataSource.badRequest.getFailure());
    }
  }
}
