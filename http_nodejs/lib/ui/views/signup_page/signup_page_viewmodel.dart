import 'package:http_nodejs/models/user.dart';
import 'package:http_nodejs/services/api.dart';
import 'package:http_nodejs/ui/widgets/form_model/form_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'package:http_nodejs/ui/views/signup_page/signup_page_view.form.dart';

class SignupPageViewModel extends AuthenticationForm {
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  String errorText = '';

//navigate to the Onboarding Screen
  dynamic openBackPageView() {
    _navigationService.navigateTo(Routes.onboardingView);
  }

//check conditions before navigate to the ForgotPassword Screen
  dynamic openHomePageView() {
    //checks if user knows how to sign up
    if (emailValue == null) {
      errorText = 'Email and Password required.';
      notifyListeners();
    } else {
      // check to see if valid email is used
      if (emailValue.contains('@')) {
        // check to see if password has enough characters
        if (passwordValue.length <= 5) {
          errorText = 'password requires at least six characters';
          notifyListeners();
        } else {
          // confirms if user is ready to use password
          if (passwordValue == confirmPasswordValue) {
            // set ui to busy while api is at work
            runBusyFuture(signup());
          } else {
            errorText = 'Password not identical';
            notifyListeners();
          }
        }
      } else {
        errorText = 'provide valid email';
        notifyListeners();
      }
    }
  }

// handles the api before navigating
  Future signup() async {
    User _userSignUp = User(email: emailValue, password: passwordValue);

    errorText = 'There is no internet connection';
    notifyListeners();

    // sends http post
    var response = await _api.postSignup(body: _userSignUp);

    if (response.isSent == true) {
      // navigate user to LoginPage Screen
      _navigationService.navigateTo(Routes.loginPageView);
    } else {
      // displays all failed cases from the api
      if (response.message != null) {
        errorText = response.message;
        notifyListeners();
      } else {
        if (response.error != null) {
          errorText = response.error;
          notifyListeners();
        } else {
          errorText = 'Sign up failed.';
          notifyListeners();
        }
      }
    }
  }
}
