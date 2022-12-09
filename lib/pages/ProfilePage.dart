// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_const_constructors, curly_braces_in_flow_control_structures, await_only_futures, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/shared/font.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: bgBlueWhite,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
            height: 40.h,
            decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)))),
        Positioned(
          top: 20.h,
          left: 10.w,
          child: Stack(
            children: [
              Positioned(
                top: 10.h,
                // white container
                child: Container(
                  width: 80.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "${auth.currentUser?.displayName}",
                        style: TextStyle(
                            fontSize: 20.sp, fontFamily: TextCustom.desMedium),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${auth.currentUser?.email}",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: TextCustom.desMedium,
                            color: grey),
                      ),
                      SizedBox(height: 3.h),
                      SizedBox(
                          width: 60.w,
                          height: 5.h,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(logout)),
                              onPressed: () async {
                                auth.signOut().then((value) => {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return WelcomePage();
                                      }))
                                    });
                              },
                              child: Text('LOG OUT'))),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80.w,
                height: 50.h,
                // decoration: BoxDecoration(
                //   color: black,
                // ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 70,
                    child: Image.asset(
                      "assets/image/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
