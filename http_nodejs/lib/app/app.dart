import 'package:http_nodejs/services/api.dart';
import 'package:http_nodejs/services/email.dart';
import 'package:http_nodejs/ui/views/forgot_password/forgot_password_view.dart';
import 'package:http_nodejs/ui/views/home_page/home_page_view.dart';
import 'package:http_nodejs/ui/views/login_page/login_page_view.dart';
import 'package:http_nodejs/ui/views/my_home_page/my_home_page_view.dart';
import 'package:http_nodejs/ui/views/new_note/new_note_view.dart';
import 'package:http_nodejs/ui/views/onboarding/onboarding_view.dart';
import 'package:http_nodejs/ui/views/password_changed_successfully/password_changed_successfully_view.dart';
import 'package:http_nodejs/ui/views/reset_password/reset_password_view.dart';
import 'package:http_nodejs/ui/views/signup_page/signup_page_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: MyHomePageView, initial: true),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: SignupPageView),
    MaterialRoute(page: LoginPageView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: ResetPasswordView),
    MaterialRoute(page: PasswordChangedSuccessfullyView),
    MaterialRoute(page: HomePageView),
    MaterialRoute(page: NewNoteView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: Email),
    LazySingleton(classType: Api)
  ],
)
class AppSetup {
// class serve no purpose besides having an annotation
}
