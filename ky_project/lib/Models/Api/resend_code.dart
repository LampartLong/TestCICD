class ResendCodeRequest {
  late String mailAddress;

  ResendCodeRequest({required this.mailAddress});

  Map<String, dynamic> toJson() => {
        'mailaddress': mailAddress,
      };
}
