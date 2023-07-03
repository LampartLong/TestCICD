import 'dart:convert';
import 'dart:io';
import 'package:ky_project/Commons/Services/api_common.dart';
import 'package:ky_project/Commons/Services/ky_api_service.dart';
import 'package:ky_project/Commons/api_const.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Models/Api/authorize_onetime_code.dart';
import 'package:ky_project/Models/Api/create_account.dart';
import 'package:ky_project/Models/Api/forgot_password_confirm_model.dart';
import 'package:ky_project/Models/Api/forgot_password_model.dart';
import 'package:ky_project/Models/Api/login_model.dart';
import 'package:ky_project/Models/Api/resend_code.dart';
import 'package:ky_project/Models/notification_model.dart';
import 'package:ky_project/Models/schedule_model.dart';

class ApiServices {
  CommonApiRequest apiRequest = CommonApiRequest();

  static const successCode = 200;
  static const createdCode = 201;
  static const errorBadCode = 400;
  static String loginToken = "";

  Future<bool> createAccount(String email, String password) async {
    try {
      apiRequest.uri = apiCreateAccount;
      apiRequest.body =
          jsonEncode(AccountRequest(mailAddress: email, password: password));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);

      if (apiResponse?.code != createdCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      return true;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<bool> authorizeOnetimeCode(String email, String code) async {
    try {
      apiRequest.uri = apiAuthorizeOnetimeCode;
      apiRequest.body = jsonEncode(
          AuthorizeOnetimeCodeRequest(mailAddress: email, code: code));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);
      if (apiResponse?.code != createdCode &&
          apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      return true;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<bool> resendCode(String email) async {
    try {
      apiRequest.uri = apiAuthorizeOnetimeCode;
      apiRequest.body = jsonEncode(ResendCodeRequest(mailAddress: email));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);
      if (apiResponse?.code != createdCode &&
          apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      return true;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<String> login(String email, String password) async {
    try {
      apiRequest.uri = apiLogin;
      apiRequest.body =
          jsonEncode(LoginRequest(mailAddress: email, password: password));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);

      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      loginToken = LoginResponse.fromJson(apiResponse?.data).token;

      return loginToken;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      apiRequest.uri = apiForgotPassword;
      apiRequest.body = jsonEncode(ForgotPasswordRequest(mailAddress: email));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);
      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }
      return true;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<bool> forgotPasswordConfirm(
      String email, String password, String code) async {
    try {
      apiRequest.uri = apiForgotPasswordConfirm;
      apiRequest.body = jsonEncode(ForgotPasswordConfirmRequest(
        mailAddress: email,
        password: password,
        code: code,
      ));
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().postExecutor(apiRequest);
      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }
      return true;
    } on SocketException {
      rethrow;
    } on KyException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<Schedule>> getDataSchedule(String param) async {
    try {
      List<Schedule> result = [];

      apiRequest.uri = "$apiSchedule?$param";
      apiRequest.requestHeaders = {
        "Content-type": "application/json",
        "Authorization": "$authorization$loginToken"
      };

      KyApiResponse? apiResponse =
      await KyApiServices().getExecutor(apiRequest);
      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      for (var row in apiResponse?.data) {
        result.add(Schedule.fromJson(row));
      }

      return result;
    } on SocketException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<bool> deleteDataSchedule(String param) async {
    try {
      return true;
      apiRequest.uri = apiSchedule;
      apiRequest.requestHeaders = {
        "Content-type": "application/json",
        "Authorization": "$authorization$loginToken"
      };

      KyApiResponse? apiResponse =
      await KyApiServices().deleteExecutor(apiRequest);
      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      return true;
    } on SocketException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<Notification>> getDataNotification() async {
    try {
      List<Notification> result = [];

      apiRequest.uri = apiGetNotificationList;
      apiRequest.requestHeaders = {"Content-type": "application/json"};

      KyApiResponse? apiResponse =
      await KyApiServices().getExecutor(apiRequest);

      if (apiResponse?.code != successCode) {
        throw KyException.fromJson(apiResponse?.errors);
      }

      for (var row in apiResponse?.data) {
        result.add(Notification.fromJson(row));
      }
      return result;
    } on SocketException {
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }
}
