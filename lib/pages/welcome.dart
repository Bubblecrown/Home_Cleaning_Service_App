// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/pages/login.dart';
import 'package:home_cleaning_service_app/pages/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String btnSignup = capitalize("create account");
    String btnLogin = capitalize("continues with your account");
    String title = capitalize("clean hub");
    String description =
        "Keep your home clean and pristine by enlisting the help of a professional cleaner as often as you need.";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/welcome/banner.png"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primary,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Bold"
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.175,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: primary),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }));
                            },
                            child: Text(btnLogin)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(primary: primary),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterPage();
                              }));
                            },
                            child: Text(btnSignup)),
                      )
                    ],
                  ),
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
