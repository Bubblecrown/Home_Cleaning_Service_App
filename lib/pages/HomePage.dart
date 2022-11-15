// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';

import '../data/Users.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${auth.currentUser?.email}"),
            ElevatedButton(
                onPressed: () {
                  auth.signOut().then((value) => {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return WelcomePage();
                        }))
                      });
                },
                child: Text('Log out'))
          ],
        ),
      ),
    );
  }
}
