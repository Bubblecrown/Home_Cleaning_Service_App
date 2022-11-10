import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/pages/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  
  Widget build(BuildContext context) {
    String title = capitalize("home hub");
    String description = capitalize("Let's make awesome changes to your home.");
    String btnLogin = capitalize("login");
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your username',
                        ),
                      ),
                      TextFormField(
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
                  child:
                      ElevatedButton(onPressed: () {}, child: Text(btnLogin))),
            ],
          ),
        ),
      ),
    );
  }
}
