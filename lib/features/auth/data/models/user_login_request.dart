class UserLoginRequest {
  String phoneNumber;
  String password;

  UserLoginRequest(this.phoneNumber, this.password);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}
