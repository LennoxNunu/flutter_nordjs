import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/password_changed_successfully/password_changed_successfully_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PasswordChangedSuccessfullyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<PasswordChangedSuccessfullyViewModel>.reactive(
      viewModelBuilder: () => PasswordChangedSuccessfullyViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/image/success.png"))),
              ),
              Text(
                "Successful!",
                style: TextStyle(fontSize: 35),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "You have successfully changed your password. Please use your new password to login!",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                child: InkWell(
                  onTap: () => model.openHomePageView(),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.blue,
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
