// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/reserveData.dart';
import 'package:sizer/sizer.dart';

class ReservePage extends StatefulWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(
                child: Form(
                    // key: formKey,
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // email form
                      TextFormField(
                        // keyboardType: TextInputType.emailAddress,
                        // validator: MultiValidator([
                        //   EmailValidator(
                        //       errorText: RegisterData.emailFormatError),
                        //   RequiredValidator(
                        //       errorText:
                        //           RegisterData.emailCheckBlank)
                        // ]),
                        // onSaved: (String? email) {
                        //   users.email = email!;
                        // },
                        style: TextStyle(color: greyPrimary),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            hintText: 'Enter your email',
                            prefixIcon: Icon(
                              Icons.alternate_email_outlined,
                              color: Color.fromRGBO(123, 123, 123, 1),
                            ),
                            fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                            filled: true),
                      ),
                      SizedBox(height: 15.sp),

                      // password form
                      TextFormField(
                        obscureText: true,
                        // validator: RequiredValidator(
                        //     errorText:
                        //         "You must enter your password"),
                        // onSaved: (String? password) {
                        //   users.password = password!;
                        // },
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.business_center_outlined,
                              color: Color.fromRGBO(123, 123, 123, 1),
                            ),
                            fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                            filled: true),
                      ),

                      SizedBox(height: 15.sp),

                      // Confirm password
                      TextFormField(
                        obscureText: true,
                        // validator: RequiredValidator(
                        //     errorText:
                        //         "You must enter your password again."),
                        // onSaved: (String? confirmPassword) {
                        //   users.confirmPassword = confirmPassword!;
                        // },
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(
                              Icons.business_center_outlined,
                              color: Color.fromRGBO(123, 123, 123, 1),
                            ),
                            fillColor: Color.fromRGBO(192, 192, 192, 0.20),
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
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          backgroundColor: MaterialStateProperty.all<Color>(primary)),
                      onPressed: () {},
                      child: Text(ReserveData.btnSignup))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
