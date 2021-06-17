import 'package:http_nodejs/models/user.dart';
import 'package:http_nodejs/services/api.dart';
import 'package:http_nodejs/ui/widgets/form_model/form_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'login_page_view.form.dart';

class LoginPageViewModel extends AuthenticationForm {
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  String errorText = '';

//navigate to the ForgotPassword Screen
  dynamic openForgotPasswordView() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

//navigate to the Onboarding Screen
  dynamic openBackPageView() {
    _navigationService.navigateTo(Routes.onboardingView);
  }

//check conditions before navigating to HomePage Screen
  dynamic openHomePageView() {
    errorText = '';
    notifyListeners();
    // check if email controller is null
    if (emailValue == null) {
      errorText = 'Email and Password required';
      notifyListeners();
    } else {
      // check if password controller is null
      if (passwordValue == null) {
        errorText = 'Password required';
        notifyListeners();
      } else {
        // check to see if valid email is used
        if (emailValue.contains('@')) {
          // check to see if password has enough characters
          if (passwordValue.length <= 5) {
            errorText = 'password requires at least six characters';
            notifyListeners();
          } else {
            // set ui to busy while api is at work
            runBusyFuture(login());
          }
        } else {
          errorText = 'Email not valid';
          notifyListeners();
        }
      }
    }
  }

// handles the api before navigating
  Future login() async {
    User _userSignInModel = User(email: emailValue, password: passwordValue);
    errorText = 'There is no internet connection';
    notifyListeners();
    // sends http post
    var response = await _api.postLogin(body: _userSignInModel);
    // checks if user has the credentials to login
    if (response.token != null) {
      // navigates to the HomePage Screen
      _navigationService.navigateTo(Routes.homePageView,
          arguments: HomePageViewArguments(
              userEmail: emailValue, token: response.token));
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
          errorText = 'Log in failed.';
          notifyListeners();
        }
      }
    }
  }
}
