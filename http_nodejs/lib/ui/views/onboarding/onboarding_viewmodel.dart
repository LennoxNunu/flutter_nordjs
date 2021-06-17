import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // navigates to the LoginPage Screen
  dynamic openLoginPageView() {
    _navigationService.navigateTo(Routes.loginPageView);
  }

  // nagigate to the SignupPage Screen
  dynamic openSignupPageView() {
    _navigationService.navigateTo(Routes.signupPageView);
  }
}
