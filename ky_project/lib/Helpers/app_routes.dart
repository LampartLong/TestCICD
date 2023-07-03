import 'package:get/get.dart';
import 'package:ky_project/Views/CreateAccount/CheckOnetimeCode/check_onetime_code_page.dart';
import 'package:ky_project/Views/CreateAccount/CompleteRegisterAccount/complete_register_account_page.dart';
import 'package:ky_project/Views/CreateAccount/EnterAccountInfo/enter_account_info_page.dart';
import 'package:ky_project/Views/ForgotPassword/PasswordResetConfirm/password_reset_confirm_page.dart';
import 'package:ky_project/Views/ForgotPassword/PasswordResetInsertEmail/password_reset_insert_email_page.dart';
import 'package:ky_project/Views/Home/home_binding.dart';
import 'package:ky_project/Views/ForgotPassword/PasswordResetComplete/password_reset_complete_page.dart';
import 'package:ky_project/Views/Home/home_page.dart';
import 'package:ky_project/Views/Loading/loading_page.dart';
import 'package:ky_project/Views/Login/login_page.dart';

class AppRoutes {
  static const home = "/home";
  static const loading = "/loading";
  static const login = "/login";
  static const enterAccountInfo = "/login/enterAccountInfo";
  static const checkOnetimeCode = "/login/checkOnetimeCode";
  static const completeRegisterAccount = "/login/enterAccountInfo/completeRegisterAccount";
  static const passwordResetInsertEmail = "/login/forgotPassword/passwordResetInsertEmail";
  static const passwordResetConfirm = "/login/forgotPassword/passwordResetConfirm";
  static const passwordResetComplete = "/login/forgotPassword/passwordResetComplete";

  static final List<GetPage> routes = [
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: loading, page: () => LoadingPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: enterAccountInfo, page: () => EnterAccountInfoPage()),
    GetPage(name: checkOnetimeCode, page: () => CheckOneTimeCodePage()),
    GetPage(name: completeRegisterAccount, page: () => CompleteRegisterAccountPage()),
    GetPage(name: passwordResetInsertEmail, page: () => PasswordResetInsertEmailPage()),
    GetPage(name: passwordResetConfirm, page: () => PasswordResetConfirmPage()),
    GetPage(name: passwordResetComplete, page: () => PasswordResetCompletePage()),
  ];
}
