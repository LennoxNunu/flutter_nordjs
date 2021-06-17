import 'package:flutter/material.dart';
import 'package:http_nodejs/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      // initialRoute: Routes.myHomePageView,
      // onGenerateRoute: r.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      //navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
