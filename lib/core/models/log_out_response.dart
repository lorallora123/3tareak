class LogOutResponse {
  final String? status;
  final String? message;

  LogOutResponse({this.status, this.message});

  factory LogOutResponse.fromJson(Map<String, dynamic>? json) {
    return LogOutResponse(
      status: json?['status'] ?? '',
      message: json?['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
