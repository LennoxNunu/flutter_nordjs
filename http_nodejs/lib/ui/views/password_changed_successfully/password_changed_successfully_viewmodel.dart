import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';

class PasswordChangedSuccessfullyViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //navigates to the HomePage Screen
  dynamic openHomePageView() {
    _navigationService.navigateTo(Routes.loginPageView);
  }
}
