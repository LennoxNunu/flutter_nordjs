import 'dart:math';

import 'package:http_nodejs/ui/widgets/form_model/form_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'package:http_nodejs/services/email.dart';
import 'package:http_nodejs/ui/views/forgot_password/forgot_password_view.form.dart';

class ForgotPasswordViewModel extends AuthenticationForm {
  final _navigationService = locator<NavigationService>();
  final _fireEmail = locator<Email>();
  String errorText = '';
  bool isValide = true;

  //navigate to ResetPassword Screen
  dynamic openResetPasswordView() {
    // Check if user knows where to put email
    if (emailValue == null) {
      errorText = 'Email is required';
      notifyListeners();
    } else {
      //Checks if user has put a valid email
      if (emailValue.contains('@')) {
        errorText = '';
        notifyListeners();
        // create a random four digit number
        Random code = new Random();
        Random code2 = new Random();
        int resetCodeDigit = code.nextInt(1000) + code2.nextInt(1000) + 1000;
        String resetCode = resetCodeDigit.toString();
        // send email to user to get the reset code
        _fireEmail.sendMail(
            resetcode: resetCode.toString(), userEmail: emailValue);
        // navigate to ResetPassword Screen
        _navigationService.navigateTo(Routes.resetPasswordView,
            arguments: ResetPasswordViewArguments(
                resetCode: resetCode, userEmail: emailValue));
      } else {
        errorText = 'Email not valid';
        isValide = false;
        notifyListeners();
      }
    }
  }

// navigate to the LoginPage Screen
  dynamic openLoginPageView() {
    _navigationService.navigateTo(Routes.loginPageView);
  }
}
