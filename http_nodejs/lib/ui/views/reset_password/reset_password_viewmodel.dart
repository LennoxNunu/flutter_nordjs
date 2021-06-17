import 'package:http_nodejs/models/user.dart';
import 'package:http_nodejs/services/api.dart';
import 'package:http_nodejs/ui/widgets/form_model/form_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'package:http_nodejs/ui/views/reset_password/reset_password_view.form.dart';

class ResetPasswordViewModel extends AuthenticationForm {
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  String passwordNotMatch = '';
  String resetCodeNotMatch = '';
  bool isUserValid = true;
  String errorText = '';

  // navigates to the SuccessPage Screen
  dynamic openSuccessPageView({String resetCode, String userEmail}) {
    //  checks if the password is long enough
    if (resetPasswordValue.length <= 5) {
      passwordNotMatch = 'password requires at least six characters';
      notifyListeners();
    } else {
      // checks if user s ready to use the password
      if (resetPasswordValue == confirmedResetPasswordValue) {
        if (resetCode == resetCodeValue) {
          runBusyFuture(updateUser(userEmail));
        } else {
          passwordNotMatch = '';
          resetCodeNotMatch = 'reset code expired.';
          isUserValid = false;
          notifyListeners();
        }
      } else {
        resetCodeNotMatch = '';
        passwordNotMatch = 'password not matching';
        notifyListeners();
      }
    }
  }

  // connects to api to update users password
  Future updateUser(String userEmail) async {
    User _userpassword = User(email: userEmail, password: resetPasswordValue);

    errorText = 'There is no internet connection';
    notifyListeners();

    // sends http patch
    var response = await _api.patchUser(body: _userpassword);
    // checks if api changed password
    if (response.isSent == true) {
      _navigationService.navigateTo(Routes.passwordChangedSuccessfullyView);
    } else {
      // handles all failed cases
      if (response.message != null) {
        errorText = response.message;
        notifyListeners();
      } else {
        if (response.error != null) {
          errorText = response.error;
          notifyListeners();
        } else {
          errorText = 'Password update failed, check internet connection.';
          notifyListeners();
        }
      }
    }
  }

  // navigates to the ForgotPassword Screen
  dynamic openForgotPasswordPageView() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  // navigates to the LoginPage Screen
  dynamic openLoginPageView() {
    _navigationService.navigateTo(Routes.loginPageView);
  }
}
