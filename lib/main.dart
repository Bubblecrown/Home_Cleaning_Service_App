// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/pages/LocationPage.dart';
import 'package:home_cleaning_service_app/pages/SplashScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:home_cleaning_service_app/wrapper.dart';

void main() {
  runApp(const MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

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
            home: Wrapper()
        );
      }
    });
  }
}

// SplashScreen()
