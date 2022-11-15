// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/Users.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Users users = Users(email: '', password: '', confirmPassword: '');

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    String title = capitalize("home hub");
    String description = capitalize("Let's make awesome changes to your home.");
    String btnLogin = capitalize("login");
    String success = capitalize("your account has been successfully created");

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

            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title),
                    Text(description),
                    SizedBox(
                      child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: MultiValidator([
                                    EmailValidator(
                                        errorText: "Invalid Email Format"),
                                    RequiredValidator(
                                        errorText: "You must enter your email")
                                  ]),
                                  onSaved: (String? email) {
                                    users.email = email!;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email',
                                      hintText: 'Enter your email'),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: RequiredValidator(
                                      errorText:
                                          "You must enter your password"),
                                  onSaved: (String? password) {
                                    users.password = password!;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'Enter your Password'),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: RequiredValidator(
                                      errorText:
                                          "You must enter your password"),
                                  onSaved: (String? confirmPassword) {
                                    users.confirmPassword = confirmPassword!;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Confirm Password',
                                      hintText: 'Enter your Password'),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              
                              if (formKey.currentState!.validate()) {
                                formKey.currentState?.save();
                                try {
                                  if (users.password == users.confirmPassword) {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: users.email,
                                            password: users.password)
                                        .then((value) => {
                                              formKey.currentState?.reset(),
                                              Fluttertoast.showToast(
                                                  msg: success,
                                                  gravity: ToastGravity.TOP),
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return WelcomePage();
                                              }))
                                            });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Password and Confirm-password is not match.",
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
                            child: Text(btnLogin))),
                  ],
                ),
              ),
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
