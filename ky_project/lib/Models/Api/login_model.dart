class LoginRequest {
  late String mailAddress;
  late String password;

  LoginRequest({required this.mailAddress, required this.password});

  Map<String, dynamic> toJson() => {
    'mailaddress': mailAddress,
    'password': password,
  };
}

class LoginResponse {
  late String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}
