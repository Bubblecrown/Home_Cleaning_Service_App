// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/pages/HomePage.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';

import '../data/Users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Users users = Users(
    email: '',
    password: '',
    confirmPassword: ''
  );

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    String title = capitalize("home hub");
    String description = capitalize("Let's make awesome changes to your home.");
    String btnLogin = capitalize("login");

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
            backgroundColor: Colors.yellow,
            appBar: AppBar(
              title: Text('Login'),
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
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: users.email,
                                          password: users.password).then((value) => {formKey.currentState?.reset(),});
                                          Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return HomePage();
                                            }));
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: '${e.message}',
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
