import 'package:flutter/material.dart';
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
    username: ' ',
    email: ' ',
    password: ' ',
  );
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
                            keyboardType: TextInputType.emailAddress,
                            validator: RequiredValidator(
                                errorText: "You must enter your name"),
                            onSaved: (String? username) {
                              users.username = username!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your username',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: RequiredValidator(
                                errorText: "You must enter your email"),
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
                                errorText: "You must enter your password"),
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          print(
                              "username = ${users.username} email = ${users.email} password = ${users.password}");
                          formKey.currentState?.reset();
                        }
                      },
                      child: Text(btnLogin))),
            ],
          ),
        ),
      ),
    );
  }
}
