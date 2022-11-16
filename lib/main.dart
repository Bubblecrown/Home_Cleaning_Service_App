import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/pages/SplashScreen.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Home cleaning service app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen());
      }
    });
  }
}


