// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/pages/HomePage.dart';
import 'package:home_cleaning_service_app/pages/LocationPage.dart';
import 'package:home_cleaning_service_app/pages/MapLocationPage.dart';
import 'package:home_cleaning_service_app/pages/Reserve.dart';
import 'package:home_cleaning_service_app/pages/SplashScreen.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:home_cleaning_service_app/shared/NavigationBar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
