class AccountRequest {
  late String mailAddress;
  late String password;

  AccountRequest({required this.mailAddress, required this.password});

  Map<String, dynamic> toJson() => {
    'mailaddress': mailAddress,
    'password': password,
  };
}
