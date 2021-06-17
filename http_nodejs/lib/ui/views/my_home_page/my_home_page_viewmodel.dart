import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http_nodejs/app/app.router.dart';
import 'package:http_nodejs/app/app.locator.dart';

class MyHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //navigate user to Onboarding Screen
  dynamic openOnboardingView() {
    _navigationService.navigateTo(Routes.onboardingView);
  }
}
