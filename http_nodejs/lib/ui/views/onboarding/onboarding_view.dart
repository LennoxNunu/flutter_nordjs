import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:http_nodejs/ui/widgets/app_page_view/state_page_view.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        //   body: Text('move to right page'),
        body: Stack(
          children: <Widget>[
            StatePageView(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.blue,
                  //   padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => model.openSignupPageView(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 9),
                                  blurRadius: 20,
                                  spreadRadius: 3)
                            ]),
                            child: Text(
                              "Get Started",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () => model.openLoginPageView(),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}
