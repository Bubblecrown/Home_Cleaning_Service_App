// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/model/Users.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Users users = Users(
    email: ' ',
    password: ' ',
  );

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    String title = capitalize("home hub");
    String description = capitalize("Let's make awesome changes to your home.");
    String btnLogin = capitalize("login");
    String success = capitalize("your account has been successfully created ");
    return FutureBuilder(
      future: firebase,
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
                                    labelText: 'Enter your email',
                                  ),
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
                                    labelText: 'Enter your password',
                                  ),
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
                                      .createUserWithEmailAndPassword(
                                          email: users.email,
                                          password: users.password);
                                  formKey.currentState?.reset();
                                  Fluttertoast.showToast(
                                    msg: success,
                                    gravity: ToastGravity.TOP
                                    );
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                      return WelcomePage();
                                    }));
                                } on FirebaseAuthException catch (e) {
                                  print(e.message);
                                  Fluttertoast.showToast(
                                    msg: e.message!,
                                    gravity: ToastGravity.TOP
                                    );
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
