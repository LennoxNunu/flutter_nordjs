import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/forgot_password/forgot_password_view.form.dart';
import 'package:http_nodejs/ui/views/forgot_password/forgot_password_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'forgot_password_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
])
class ForgotPasswordView extends StatelessWidget with $ForgotPasswordView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  "Please enter your mail ID to receive your password and reset information",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Mail ID', style: TextStyle(fontSize: 23)),
                TextField(
                  decoration: InputDecoration(hintText: "john@example.com"),
                  style: TextStyle(fontSize: 20),
                  controller: emailController,
                ),
                !model.isValide
                    ? Column(
                        children: <Widget>[
                          Text(model.errorText,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.red)),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 40,
                      ),
                InkWell(
                  onTap: () async {
                    await model.openResetPasswordView();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.blue,
                    ),
                    child: Text(
                      "Send Request",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ForgotPasswordViewModel(),
    );
  }
}
