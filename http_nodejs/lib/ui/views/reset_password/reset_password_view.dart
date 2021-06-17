import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/reset_password/reset_password_view.form.dart';
import 'package:http_nodejs/ui/views/reset_password/reset_password_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'reset_password_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'resetCode'),
  FormTextField(name: 'resetPassword'),
  FormTextField(name: 'confirmedResetPassword'),
])
class ResetPasswordView extends StatelessWidget with $ResetPasswordView {
  final String resetCode;
  final String userEmail;
  ResetPasswordView({this.resetCode, this.userEmail});

  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => ResetPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => model.openLoginPageView(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
                style: TextStyle(fontSize: 35),
              ),
              Text(
                "Reset code was sent to your mail Id. Please enter the code and create a new password",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Reset code",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              TextField(
                controller: resetCodeController,
                decoration: InputDecoration(hintText: "****"),
                style: TextStyle(fontSize: 20),
              ),
              model.resetCodeNotMatch != null
                  ? Text(
                      model.resetCodeNotMatch,
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    )
                  : SizedBox(
                      height: 16,
                    ),
              model.isUserValid
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        TextField(
                          controller: resetPasswordController,
                          decoration: InputDecoration(
                              hintText: "Enter your password here"),
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        TextField(
                          controller: confirmedResetPasswordController,
                          decoration: InputDecoration(
                              hintText: "Re-Enter your password here"),
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          model.passwordNotMatch,
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              model.openSuccessPageView(
                                  resetCode: resetCode,
                                  userEmail: this.userEmail);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 84, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: Colors.blue,
                              ),
                              child: model.isBusy
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    )
                                  : Text(
                                      "Change Password",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'You are required to send your email for further verification.',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => model.openForgotPasswordPageView(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 84, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: Colors.blue,
                              ),
                              child: Text(
                                "Send Email",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
