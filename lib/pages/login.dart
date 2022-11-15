// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/loginData.dart';
import 'package:home_cleaning_service_app/pages/HomePage.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:sizer/sizer.dart';

import '../data/Users.dart';
import '../data/font.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Users users = Users(email: '', password: '', confirmPassword: '');

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Error internet")),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: primary,
            resizeToAvoidBottomInset: false,

            // appbar
            appBar: AppBar(
              leading: BackButton(onPressed: (() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return WelcomePage();
                }));
              })),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),

            // Body
            body: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  top: 5.h,
                  right: 0,
                  left: 0,
                  child: Container(
                    child: Stack(
                      children: [
                        Image.asset(LoginData.image),
                        Positioned(
                          top: 5.h,
                          width: 50.w,
                          left: 30.sp,
                          child: Text(
                            LoginData.title,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: TextCustom.subBold,
                                color: white),
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          width: 50.w,
                          left: 30.sp,
                          child: Text(LoginData.header,
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: TextCustom.headerBold,
                                  color: white)),
                        ),
                      ],
                    ),
                  ),
                ),

                // Container white
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    padding: EdgeInsets.all(30.sp),
                    width: 100.w,
                    height: 70.h,
                    child: Column(
                      children: [
                        // description
                        SizedBox(
                          width: 70.w,
                          height: 8.h,
                          child: Text(
                            LoginData.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 15.sp,
                              fontFamily: TextCustom.desBold,
                            ),
                          ),
                        ),

                        // form
                        SizedBox(
                          child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // email form
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: MultiValidator([
                                        EmailValidator(
                                            errorText: "Invalid Email Format"),
                                        RequiredValidator(
                                            errorText:
                                                "You must enter your email")
                                      ]),
                                      onSaved: (String? email) {
                                        users.email = email!;
                                      },
                                      style: TextStyle(color: greyPrimary),
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          hintText: 'Enter your email',
                                          prefixIcon: Icon(
                                            Icons.alternate_email_outlined,
                                            color: Color.fromRGBO(
                                                123, 123, 123, 1),
                                          ),
                                          fillColor: Color.fromRGBO(
                                              192, 192, 192, 0.20),
                                          filled: true),
                                    ),
                                    SizedBox(height: 15.sp),

                                    // password form
                                    TextFormField(
                                      obscureText: true,
                                      validator: RequiredValidator(
                                          errorText:
                                              "You must enter your password"),
                                      onSaved: (String? password) {
                                        users.password = password!;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          hintText: 'Password',
                                          prefixIcon: Icon(
                                            Icons.business_center_outlined,
                                            color: Color.fromRGBO(
                                                123, 123, 123, 1),
                                          ),
                                          fillColor: Color.fromRGBO(
                                              192, 192, 192, 0.20),
                                          filled: true),
                                    )
                                  ],
                                ),
                              )),
                        ),

                        SizedBox(height: 5.h),

                        // login button
                        SizedBox(
                            width: 50.w,
                            height: 7.h,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primary)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: users.email,
                                              password: users.password)
                                          .then((value) => {
                                                formKey.currentState?.reset(),
                                              });
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomePage();
                                      }));
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: '${e.message}',
                                          gravity: ToastGravity.TOP);
                                    }
                                  }
                                },
                                child: Text(LoginData.btnLogin))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
