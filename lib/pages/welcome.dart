// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/font.dart';
import 'package:home_cleaning_service_app/data/welcomeData.dart';
import 'package:home_cleaning_service_app/pages/login.dart';
import 'package:home_cleaning_service_app/pages/register.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // sub title
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Text(
                      WelcomeData.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Secondary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextCustom.subBold),
                    ),
                  ),
                  // end sub title

                  // title
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Text(
                      WelcomeData.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primary,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextCustom.headerBold),
                    ),
                  ),
                  // end title

                  // image
                  Image.asset(WelcomeData.image),
                  // end image

                  // description
                  SizedBox(
                    width: 70.w,
                    height: 15.h,
                    child: Text(
                      WelcomeData.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 9.sp,
                          fontFamily: TextCustom.desMedium,
                          height: 1.sp),
                    ),
                  ),
                  // end description

                  // login button
                  SizedBox(
                    width: 50.w,
                    height: 7.h,
                    child: ElevatedButton(
                      
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primary)),
                        onPressed: () {
                          
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(WelcomeData.btnLogin)),
                  ),
                  // end login button

                  // signup htperlink
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: WelcomeData.textHyperlink,
                          style: TextStyle(
                              color: black,
                              fontFamily: TextCustom.desThin,
                              fontSize: 8.sp)),
                      WidgetSpan(
                          child: SizedBox(
                        height: 4.h,
                        width: 4.sp,
                      )),
                      TextSpan(
                          text: WelcomeData.btnSignup,
                          style: TextStyle(
                              color: primary,
                              fontFamily: TextCustom.desMedium,
                              fontSize: 8.sp),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterPage();
                              }));
                            }),
                    ]),
                  ),
                  // end signup htperlink
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String capitalize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
