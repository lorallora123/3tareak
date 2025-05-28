// ignore_for_file: non_constant_identifier_names

class Failure {
  int code;
  String message;

  Failure({required this.code, required this.message});

  factory Failure.Default() => Failure(code: 0, message: "");
}
