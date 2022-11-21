// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_const_constructors, curly_braces_in_flow_control_structures, await_only_futures, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/model/Users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;
  String? firstName;
  String? lastName;
  final auth = FirebaseAuth.instance;
  Future getData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("user_accounts")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        firstName = ds.data()?["first_name"];
        print(firstName);
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Text("Loading data...Please wait");
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("firstName : $firstName"),
                Text("firstName : ${auth.currentUser?.email}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
