// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/font.dart';
import 'package:home_cleaning_service_app/pages/ProfilePage.dart';
import 'package:home_cleaning_service_app/pages/Reserve.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:sizer/sizer.dart';

import '../model/Users.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Max Size
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: bgWhite,
              height: 70.h,
              width: double.infinity,
            ),
          ),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
                color: primary,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100))),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            right: 8.w,
            child: Container(
              height: 20.h,
              width: 100.w,
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This summer",
                              style: TextStyle(
                                color: whiteSecondary,
                                fontSize: 14.sp,
                                fontFamily: TextCustom.subBold,
                              ),
                            ),
                            Text(
                              "Discounts",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 30.sp,
                                  fontFamily: TextCustom.subBold),
                            )
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: bgBlue,
                          child: Icon(
                            Icons.logout_outlined,
                            color: white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Center(
//   child: ListView(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Welcome ${auth.currentUser?.email}",
//                 style: TextStyle(fontSize: 20.sp)),
//             ElevatedButton(
//                 onPressed: () {
//                   auth.signOut().then((value) => {
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (context) {
//                           return WelcomePage();
//                         }))
//                       });
//                 },
//                 child: Text('Log out')),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
