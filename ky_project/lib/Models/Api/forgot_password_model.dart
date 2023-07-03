class ForgotPasswordRequest {
  final String mailAddress;

  ForgotPasswordRequest({required this.mailAddress});

  Map<String, dynamic> toJson() => {
        'mailaddress': mailAddress,
      };
}
