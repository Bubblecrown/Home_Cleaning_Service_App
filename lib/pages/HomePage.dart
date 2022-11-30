// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/shared/font.dart';
import 'package:home_cleaning_service_app/model/service.dart';
import 'package:home_cleaning_service_app/pages/LocationPage.dart';
import 'package:home_cleaning_service_app/pages/ProfilePage.dart';
import 'package:home_cleaning_service_app/pages/Reserve.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:sizer/sizer.dart';

import '../model/Carousel.dart';
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
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Max Size
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: bgWhite,
              height: double.infinity,
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
            top: 10.h,
            left: 8.w,
            right: 8.w,
            child: Container(
              height: 20.h,
              width: 100.w,
              child: Container(
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
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: bgBlue,
                        child: Icon(
                          Icons.logout_outlined,
                          color: white,
                        ),
                      ),
                      onTap: () {
                        auth.signOut().then((value) => {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return WelcomePage();
                              }))
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 18.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              child: CarouselSlider.builder(
                itemCount: dataList.length,
                itemBuilder: ((context, index, realIndex) {
                  final imageList = dataList[index];
                  return buildImage(imageList, index);
                }),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.75,
                  aspectRatio: 1.9,
                  initialPage: 3,
                ),
              ),
            ),
          ),
          Positioned(
            top: 42.h,
            left: 8.w,
            right: 8.w,
            child: Text(
              "Services",
              style: TextStyle(
                  color: primary,
                  fontSize: 30.sp,
                  fontFamily: TextCustom.subBold),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 0.w,
            right: 0.w,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    width: 50.w,
                    child: GestureDetector(
                      child: Image.network(
                        service[0],
                        fit: BoxFit.cover,
                      ),
                      onTap: (() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LocationPage();
                        }));
                      }),
                    ),
                  ),
                  Container(
                    width: 50.w,
                    child: Image.network(
                      service[1],
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 50.w,
                    child: Image.network(
                      service[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 50.w,
                    child: Image.network(
                      service[3],
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget buildImage(String imageList, int index) => Container(
        width: 100.w,
        child: Image.network(
          imageList,
          fit: BoxFit.cover,
        ),
      );
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


// StreamBuilder(
//             stream: slides,
//             builder: (context, AsyncSnapshot snap) {
//               List slidesItem = snap.data.toList();
//               if (snap.hasError) {
//                 return Text("${snap.error}");
//               }
//               if (snap.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//               return PageView.builder(
//                 itemCount: ,
//                 itemBuilder: (context, index) {

//               });
//             },
//           )