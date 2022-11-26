// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, dead_code, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/model/Users.dart';
import 'package:home_cleaning_service_app/data/font.dart';
import 'package:home_cleaning_service_app/data/registerData.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:home_cleaning_service_app/services/UserAccount.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';

import '../services/database.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Users users = Users(
      uid: '',
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      confirmPassword: '');

  Future storeUserAccount(
      String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('user_accounts').add({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    });
  }

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
            // resizeToAvoidBottomInset: false,

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
            // end appbar

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
                        // image and title
                        Image.asset(RegisterData.image),

                        // sub title
                        Positioned(
                          top: 6.h,
                          width: 50.w,
                          left: 30.sp,
                          child: Text(
                            RegisterData.title,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: TextCustom.subBold,
                                color: white),
                          ),
                        ),

                        // title
                        Positioned(
                          top: 12.h,
                          width: 50.w,
                          left: 30.sp,
                          child: Text(RegisterData.header,
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
                    height: 75.h,

                    // Listview
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // description
                        SizedBox(
                          width: 70.w,
                          height: 8.h,
                          child: Text(
                            RegisterData.description,
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
                                    // first name form
                                    TextFormField(
                                      keyboardType: TextInputType.name,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                'You must enter your first name.')
                                      ]),
                                      onSaved: (String? firstName) {
                                        users.firstName = firstName!;
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
                                          hintText: 'First name',
                                          prefixIcon: Icon(
                                            Icons.person_outlined,
                                            color: Color.fromRGBO(
                                                123, 123, 123, 1),
                                          ),
                                          fillColor: Color.fromRGBO(
                                              192, 192, 192, 0.20),
                                          filled: true),
                                    ),
                                    // end first name form

                                    SizedBox(height: 15.sp),

                                    // last name form
                                    TextFormField(
                                      keyboardType: TextInputType.name,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                'You must enter your Last name.')
                                      ]),
                                      onSaved: (String? lastName) {
                                        users.lastName = lastName!;
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
                                          hintText: 'Last name',
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            color: Color.fromRGBO(
                                                123, 123, 123, 1),
                                          ),
                                          fillColor: Color.fromRGBO(
                                              192, 192, 192, 0.20),
                                          filled: true),
                                    ),
                                    // end last name form

                                    SizedBox(height: 15.sp),

                                    // email form
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: MultiValidator([
                                        EmailValidator(
                                            errorText:
                                                RegisterData.emailFormatError),
                                        RequiredValidator(
                                            errorText:
                                                RegisterData.emailCheckBlank)
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
                                          hintText: 'Email',
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
                                    ),

                                    SizedBox(height: 15.sp),

                                    // Confirm password
                                    TextFormField(
                                      obscureText: true,
                                      validator: RequiredValidator(
                                          errorText:
                                              "Confirm password is required."),
                                      onSaved: (String? confirmPassword) {
                                        users.confirmPassword =
                                            confirmPassword!;
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
                                          hintText: 'Confirm Password',
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
                                      if (users.password ==
                                          users.confirmPassword) {
                                        bool hasInternet = false;
                                        final notify = hasInternet
                                            ? 'Internet already'
                                            : 'No Internet';
                                        hasInternet =
                                            await InternetConnectionChecker()
                                                .hasConnection;
                                        print(notify);
                                        Fluttertoast.showToast(
                                            msg: '${notify}',
                                            gravity: ToastGravity.TOP);
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: users.email,
                                                password: users.password)
                                            .then((value) => {
                                                  storeUserAccount(
                                                    users.firstName,
                                                    users.lastName,
                                                    users.email,
                                                  ),
                                                  formKey.currentState?.reset(),
                                                  Fluttertoast.showToast(
                                                      msg: RegisterData.success,
                                                      gravity:
                                                          ToastGravity.TOP),
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return WelcomePage();
                                                  }))
                                                });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Password and Confirm password is not match.",
                                            gravity: ToastGravity.TOP);
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      String? message;
                                      if (e.code == 'email-already-in-use') {
                                        message =
                                            'This email is already in use, please enter again';
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            'Password should more than 6 characters';
                                      } else {
                                        message = e.message;
                                      }
                                      Fluttertoast.showToast(
                                          msg: '$message',
                                          gravity: ToastGravity.TOP);
                                    }
                                  }
                                },
                                child: Text(RegisterData.btnSignup))),
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
