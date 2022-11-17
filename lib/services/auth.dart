// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_cleaning_service_app/model/Users.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';
import 'package:home_cleaning_service_app/services/database.dart';

import '../data/registerData.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserID? _userFromFirebaseUser(User userid) {
    return userid != null ? UserID(uid: userid.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User userid = result.userid;
      return _userFromFirebaseUser(userid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  final formKey = GlobalKey<FormState>();
  Users users = Users(
      uid: '', username: '', email: '', password: '', confirmPassword: '');
  late BuildContext context;

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      if (users.password == users.confirmPassword) {
        UserCredential result = await _auth
            .createUserWithEmailAndPassword(
                email: users.email, password: users.password)
            // .then((value) => {
            //       formKey.currentState?.reset(),
            //       Fluttertoast.showToast(
            //           msg: RegisterData.success, gravity: ToastGravity.TOP),
            //       Navigator.pushReplacement(context,
            //           MaterialPageRoute(builder: (context) {
            //         return WelcomePage();
            //       }))
            //     });
        User? user = result.user;
        await DatabaseService(uid: user.uid)
            .updateUserData('0', 'new crew member', 100);
        return _userFromFirebaseUser(user);
      } else {
        Fluttertoast.showToast(
            msg: "Password and Confirm-password is not match.",
            gravity: ToastGravity.TOP);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      String? message;
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use, please enter again';
      } else if (e.code == 'weak-password') {
        message = 'Password should more than 6 characters';
      } else {
        message = e.message;
      }
      Fluttertoast.showToast(msg: '$message', gravity: ToastGravity.TOP);
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
