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
  String? _uid;
  String? email;
  String? firstName;
  String? lastName;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future getData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser?.uid;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("user_accounts")
          .doc(firebaseUser)
          .get()
          .then((ds) {
        setState(() {
          firstName = ds.data()?["first_name"];
        });

        print(firstName);
        print(FirebaseAuth.instance.currentUser?.uid);
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future fetchData() async {
    User? users = auth.currentUser;
    _uid = users?.uid;
    final DocumentSnapshot userDocs = await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(auth.currentUser?.uid)
        .get();
    setState(() {
      firstName = userDocs.get('first_name');
    });

    print(firstName);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: getData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState != ConnectionState.done)
    //       return Text("Loading data...Please wait");
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
                                      MaterialStateProperty.all<Color>(
                                          logout)),
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
    )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("Name : ${auth.currentUser?.displayName}"),
        //   ],
        // ),
        );
    //   },
    // );
  }
}
