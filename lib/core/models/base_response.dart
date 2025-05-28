import 'package:take_me_with_you/core/utils/function.dart';

class BaseMapResponse<T> {
  String? status;
  String? message;
  final T? data;

  BaseMapResponse({this.status, this.data, this.message});

  factory BaseMapResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    final status = json['status'] as String?;
    final message = json['message'] as String?;
    T? data;
    if (fromJsonT != null) {
      data = fromJsonT(json['data']);
    }
    return BaseMapResponse<T>(status: status, message: message, data: data);
  }

  Map<String, dynamic> toJson(T Function(T?) toJsonT) => {
        'status': status,
        'message': message,
        'data': toJsonT(data),
      };
}

class BaseListResponse<T> {
  String? status;
  String? message;
  List<T>? data;

  BaseListResponse({this.status, this.data, this.message});

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    final status = json['status'] as String?;
    final message = json['message'] as String?;
    List<T>? data;
    if (fromJsonT != null) {
      data = (json['data'] as List<dynamic>?)
          ?.map((item) => fromJsonT(item))
          .toList();
    }
    return BaseListResponse<T>(status: status, message: message, data: data);
  }

  Map<String, dynamic> toJson(T Function(T?) toJsonT) => {
        'status': status,
        'message': message,
        'data': data?.map((item) => toJsonT(item)).toList(),
      };
}

class PaginationResponse<T> {
  int? currentPage;
  List<T>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  PaginationTypes? type;

  PaginationResponse({
    this.data,
    this.path,
    this.to,
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.perPage,
    this.prevPageUrl,
    this.type,
  });

  factory PaginationResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    final currentPage = json['current_page'] as int?;
    final data = (json['data'] as List<dynamic>?)
        ?.map((item) => fromJsonT(item))
        .toList();
    final firstPageUrl = json['first_page_url'] as String?;
    final from = json['from'] as int?;
    final nextPageUrl = json['next_page_url'] as String?;
    final path = json['path'] as String?;
    final perPage = json['per_page'] as int?;
    final prevPageUrl = json['prev_page_url'] as String?;
    final to = json['to'] as int?;
    return PaginationResponse<T>(
      currentPage: currentPage,
      data: data,
      firstPageUrl: firstPageUrl,
      from: from,
      nextPageUrl: nextPageUrl,
      path: path,
      perPage: perPage,
      prevPageUrl: prevPageUrl,
      to: to,
      type: null,
    );
  }

  Map<String, dynamic> toJson(T Function(T?) toJsonT) => {
        'current_page': currentPage,
        'data': data?.map((item) => toJsonT(item)).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
      };
}
