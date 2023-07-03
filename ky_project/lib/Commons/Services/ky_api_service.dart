import 'package:ky_project/Commons/Services/api_common.dart';

class KyApiServices extends CommonApiServices<KyApiResponse> {
  @override
  KyApiResponse fromJson(json) {
    return KyApiResponse.fromJson(json);
  }
}

class KyApiResponse {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  static const kCode = "code";
  static const kErrors = "errors";
  static const kData = "data";

  late int code;
  late dynamic errors;
  late dynamic data;

  // -------------------------------------------------------
  // Functions
  // -------------------------------------------------------
  KyApiResponse({required this.code, this.errors, this.data});

  factory KyApiResponse.fromJson(Map<dynamic, dynamic> json) {
    return KyApiResponse(
        code: json[kCode],
        errors: json[kErrors],
        data: json[kData]);
  }
}

class KyException implements Exception {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  final List<KyError> errors;

  KyException({required this.errors});

  factory KyException.fromJson(List lst) {
    return KyException(
        errors: lst.map((errors) => KyError.fromJson(errors)).toList());
  }
}

class KyError {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  static const kField = "field";
  static const kErrorMessage = "error_msg";
  static const kShowType = "show_type";

  late String? field;
  final String errorMsg;
  final int showType;

  KyError({this.field, required this.errorMsg, required this.showType});

  factory KyError.fromJson(Map<dynamic, dynamic> json) {
    return KyError(
        field: json[kField] ?? "",
        errorMsg: json[kErrorMessage] ?? "",
        showType: json[kShowType]);
  }
}
