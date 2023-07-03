class AuthorizeOnetimeCodeRequest {
  late String mailAddress;
  late String code;

  AuthorizeOnetimeCodeRequest({required this.mailAddress, required this.code});

  Map<String, dynamic> toJson() => {
        'mailaddress': mailAddress,
        'code': code,
      };
}
