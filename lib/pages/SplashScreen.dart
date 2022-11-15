// ignore_for_file: implementation_imports, annotate_overrides, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:sizer/sizer.dart';

import '../data/font.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return WelcomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    String title = capitalize('cleanon');
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: white,
                  fontSize: 48.0.sp,
                  fontFamily: TextCustom.textBold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 10,
              ),
            SpinKitSpinningLines(
              color: white,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
