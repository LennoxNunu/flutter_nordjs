// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/forgot_password/forgot_password_view.dart';
import '../ui/views/home_page/home_page_view.dart';
import '../ui/views/login_page/login_page_view.dart';
import '../ui/views/my_home_page/my_home_page_view.dart';
import '../ui/views/new_note/new_note_view.dart';
import '../ui/views/onboarding/onboarding_view.dart';
import '../ui/views/password_changed_successfully/password_changed_successfully_view.dart';
import '../ui/views/reset_password/reset_password_view.dart';
import '../ui/views/signup_page/signup_page_view.dart';

class Routes {
  static const String myHomePageView = '/';
  static const String onboardingView = '/onboarding-view';
  static const String signupPageView = '/signup-page-view';
  static const String loginPageView = '/login-page-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String resetPasswordView = '/reset-password-view';
  static const String passwordChangedSuccessfullyView =
      '/password-changed-successfully-view';
  static const String homePageView = '/home-page-view';
  static const String newNoteView = '/new-note-view';
  static const all = <String>{
    myHomePageView,
    onboardingView,
    signupPageView,
    loginPageView,
    forgotPasswordView,
    resetPasswordView,
    passwordChangedSuccessfullyView,
    homePageView,
    newNoteView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.myHomePageView, page: MyHomePageView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.signupPageView, page: SignupPageView),
    RouteDef(Routes.loginPageView, page: LoginPageView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.resetPasswordView, page: ResetPasswordView),
    RouteDef(Routes.passwordChangedSuccessfullyView,
        page: PasswordChangedSuccessfullyView),
    RouteDef(Routes.homePageView, page: HomePageView),
    RouteDef(Routes.newNoteView, page: NewNoteView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    MyHomePageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyHomePageView(),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnboardingView(),
        settings: data,
      );
    },
    SignupPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupPageView(),
        settings: data,
      );
    },
    LoginPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPageView(),
        settings: data,
      );
    },
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordView(),
        settings: data,
      );
    },
    ResetPasswordView: (data) {
      var args = data.getArgs<ResetPasswordViewArguments>(
        orElse: () => ResetPasswordViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResetPasswordView(
          resetCode: args.resetCode,
          userEmail: args.userEmail,
        ),
        settings: data,
      );
    },
    PasswordChangedSuccessfullyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PasswordChangedSuccessfullyView(),
        settings: data,
      );
    },
    HomePageView: (data) {
      var args = data.getArgs<HomePageViewArguments>(
        orElse: () => HomePageViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePageView(
          key: args.key,
          userEmail: args.userEmail,
          token: args.token,
        ),
        settings: data,
      );
    },
    NewNoteView: (data) {
      var args = data.getArgs<NewNoteViewArguments>(
        orElse: () => NewNoteViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewNoteView(
          key: args.key,
          noteId: args.noteId,
          editingScreen: args.editingScreen,
          email: args.email,
          token: args.token,
          title: args.title,
          description: args.description,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ResetPasswordView arguments holder class
class ResetPasswordViewArguments {
  final String resetCode;
  final String userEmail;
  ResetPasswordViewArguments({this.resetCode, this.userEmail});
}

/// HomePageView arguments holder class
class HomePageViewArguments {
  final Key key;
  final String userEmail;
  final String token;
  HomePageViewArguments({this.key, this.userEmail, this.token});
}

/// NewNoteView arguments holder class
class NewNoteViewArguments {
  final Key key;
  final int noteId;
  final bool editingScreen;
  final String email;
  final String token;
  final String title;
  final String description;
  NewNoteViewArguments(
      {this.key,
      this.noteId,
      this.editingScreen,
      this.email,
      this.token,
      this.title,
      this.description});
}
