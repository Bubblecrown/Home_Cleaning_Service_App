// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_const_constructors, curly_braces_in_flow_control_structures, await_only_futures, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/model/Users.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name : ${auth.currentUser?.displayName}"),
          ],
        ),
      ),
    );
    //   },
    // );
  }
}
