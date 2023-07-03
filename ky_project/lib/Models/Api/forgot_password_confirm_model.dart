// ignore_for_file: public_member_api_docs, sort_constructors_first

class ForgotPasswordConfirmRequest {
  final String mailAddress;
  final String password;
  final String code;

  ForgotPasswordConfirmRequest({required this.mailAddress, required this.password, required this.code});

  Map<String, dynamic> toJson() => {
        'mailaddress': mailAddress,
        'password': password,
        'code': code,
      };
}
