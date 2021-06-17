// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String ResetCodeValueKey = 'resetCode';
const String ResetPasswordValueKey = 'resetPassword';
const String ConfirmedResetPasswordValueKey = 'confirmedResetPassword';

mixin $ResetPasswordView on StatelessWidget {
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController confirmedResetPasswordController =
      TextEditingController();
  final FocusNode resetCodeFocusNode = FocusNode();
  final FocusNode resetPasswordFocusNode = FocusNode();
  final FocusNode confirmedResetPasswordFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    resetCodeController.addListener(() => _updateFormData(model));
    resetPasswordController.addListener(() => _updateFormData(model));
    confirmedResetPasswordController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        {
          ResetCodeValueKey: resetCodeController.text,
          ResetPasswordValueKey: resetPasswordController.text,
          ConfirmedResetPasswordValueKey: confirmedResetPasswordController.text,
        },
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    resetCodeController.dispose();
    resetPasswordController.dispose();
    confirmedResetPasswordController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String get resetCodeValue => this.formValueMap[ResetCodeValueKey];
  String get resetPasswordValue => this.formValueMap[ResetPasswordValueKey];
  String get confirmedResetPasswordValue =>
      this.formValueMap[ConfirmedResetPasswordValueKey];
}
