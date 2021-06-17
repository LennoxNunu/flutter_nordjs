import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/signup_page/signup_page_view.form.dart';
import 'package:http_nodejs/ui/views/signup_page/signup_page_viewmodel.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
  FormTextField(name: 'confirmPassword'),
])
class SignupPageView extends StatelessWidget with $SignupPageView {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<SignupPageViewModel>.reactive(
      viewModelBuilder: () => SignupPageViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => model.openBackPageView(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 35),
              ),
              Text(
                "Sign up to continue...",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              TextField(
                decoration: InputDecoration(hintText: "JohnDoe@gmail.com"),
                style: TextStyle(fontSize: 20),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Enter your password here"),
                style: TextStyle(fontSize: 20),
                controller: passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                " Confirm Password",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Confirm your password here"),
                style: TextStyle(fontSize: 20),
                controller: confirmPasswordController,
              ),
              model.errorText != ''
                  ? Text(
                      model.errorText,
                      style: TextStyle(fontSize: 23, color: Colors.red),
                    )
                  : SizedBox(
                      height: 30,
                    ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.blue,
                  ),
                  child: InkWell(
                    onTap: () => model.openHomePageView(),
                    child: model.isBusy
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            "Sign up",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
