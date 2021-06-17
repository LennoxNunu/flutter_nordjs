import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http_nodejs/ui/views/my_home_page/my_home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<MyHomePageViewModel>.reactive(
      viewModelBuilder: () => MyHomePageViewModel(),
      //  onModelReady:() => Timer(Duration(seconds: 3), openOnBoard),
      onModelReady: (model) {
        return Timer(Duration(seconds: 3), () => model.openOnboardingView());
      },
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
//            FloatingActionButton(onPressed: model.openHomePageView),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('asset/image/aking.png'),
            )),
          ),
        ),
      ),
    );
  }
}
