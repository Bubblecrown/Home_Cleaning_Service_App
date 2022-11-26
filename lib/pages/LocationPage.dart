// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/ColorScheme.dart';
import 'package:home_cleaning_service_app/shared/Field.dart';
import 'package:sizer/sizer.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final formKey = GlobalKey<FormState>();

  final List<String> district = [
    'Condo 1 BR (40 sq.m.)',
    'Condo 1 BR (50 sq.m.)',
    'Condo 2 BR (80 sq.m.)',
    'Condo 3 BR (100 sq.m.)',
    'House 1 Story (100 sq.m.)',
    'House 2-3 Stories (100-200 sq.m.)',
    'House (> 200 sq.m.)',
    'Office/ Workplace'
  ];

  // form value
  String place_name = '';
  // String place_type_selected = '';
  String remark = '';
  String address = '';
  // end form value

  final List<String> place_type = [
    'Condo 1 BR (40 sq.m.)',
    'Condo 1 BR (50 sq.m.)',
    'Condo 2 BR (80 sq.m.)',
    'Condo 3 BR (100 sq.m.)',
    'House 1 Story (100 sq.m.)',
    'House 2-3 Stories (100-200 sq.m.)',
    'House (> 200 sq.m.)',
    'Office/ Workplace'
  ];
  String place_type_selected = '';
  final List<String> province = [
    'Bangkok',
    'Nonthaburi',
    'Pathum Thani',
    'Samut Prakarn',
  ];
  String province_selected = '';
  String location = '';
  String addressDetail = '';
  String phonenumber = '';
  final List<String> duration = [
    '2 hr.',
    '3 hr.',
    '4 hr.',
    '5 hr.',
    '6 hr.',
    '7 hr.',
    '8 hr.',
  ];
  void storeBooking(String place_type_selected, String addressDetail,
      String province_selected, String phonenumber) async {
    await FirebaseFirestore.instance.collection('booking_list').add({
      'place_type': place_type_selected,
      'address_detail': addressDetail,
      'province': province_selected,
      'phone_number': phonenumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    // return
    // FutureBuilder(
    //   future: Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return Scaffold(
    //         appBar: AppBar(title: Text("Error internet")),
    //         body: Center(
    //           child: Text("${snapshot.error}"),
    //         ),
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appbar
      appBar: AppBar(
        leading: BackButton(onPressed: (() {
          Navigator.pop(context);
        })),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // end appbar

      body: ListView(children: [
        Container(),
        Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          width: 100.w,
          height: 100.h,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.sp),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    'My places',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  // end title
                  SizedBox(height: 15.sp),

                  // // label
                  // Text('Place Name'),
                  // SizedBox(height: 10.sp),
                  // // end label

                  // // place name form
                  // TextFormField(
                  //   style: TextStyle(color: greyPrimary),
                  //   validator: (val) =>
                  //       val!.isEmpty ? 'Please enter a Place Name' : null,
                  //   onChanged: (val) => setState(() => place_name = val),
                  //   decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.transparent),
                  //           borderRadius: BorderRadius.all(Radius.circular(30))),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.transparent),
                  //           borderRadius: BorderRadius.all(Radius.circular(30))),
                  //       hintText: 'e.g. My home / My condo / Office',
                  //       prefixIcon: Icon(
                  //         Icons.home_outlined,
                  //         color: Color.fromRGBO(123, 123, 123, 1),
                  //       ),
                  //       fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                  //       filled: true),
                  // ),
                  // SizedBox(height: 15.sp),
                  // // end place name form

                  // label
                  Text('Place Type'),
                  SizedBox(height: 10.sp),
                  // end label

                  // dropdown
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text('Select Place Type'),
                    value: null,
                    validator: (value) => value == null
                        ? 'You should select your place type.'
                        : null,
                    decoration: InputDecorationCustom,
                    items: place_type.map((choice) {
                      return DropdownMenuItem(
                        value: choice,
                        child: Text('$choice'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => place_type_selected = val!),
                    onSaved: (String? place_type_selected) {
                      place_type_selected = place_type_selected!;
                    },
                  ),
                  // end dropdown

                  SizedBox(height: 15.sp),

                  // label
                  Text('Address Detail'),
                  SizedBox(height: 10.sp),
                  // end label

                  // address detail form
                  TextFormField(
                    style: TextStyle(color: greyPrimary),
                    // validator: (val) =>
                    //     val!.isEmpty ? 'Please enter a Place Name' : null,
                    onChanged: (val) => setState(() => addressDetail = val),
                    onSaved: (String? addressDetail) {
                      addressDetail = addressDetail!;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        hintText: 'e.g. Near (landmark)',
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          color: Color.fromRGBO(123, 123, 123, 1),
                        ),
                        fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                        filled: true),
                  ),
                  SizedBox(height: 15.sp),
                  // end address detail form

                  // province form
                  // label
                  Text('Province'),
                  SizedBox(height: 10.sp),
                  // end label

                  // dropdown
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text('Select Province'),
                    value: null,
                    validator: (value) => value == null
                        ? 'You should select your province.'
                        : null,
                    decoration: InputDecorationCustom,
                    items: province.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text('$p'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => province_selected = val!),
                    onSaved: (String? province_selected) {
                      province_selected = province_selected!;
                    },
                  ),
                  // end dropdown

                  SizedBox(height: 15.sp),
                  // end province form

                  // label
                  Text('Phone number'),
                  SizedBox(height: 10.sp),
                  // end label

                  // phone number form
                  TextFormField(
                    style: TextStyle(color: greyPrimary),
                    keyboardType: TextInputType.phone,
                    validator: RequiredValidator(
                        errorText: 'Please enter your phone number'),
                    onChanged: (val) => setState(() => phonenumber = val),
                    onSaved: (String? phonenumber) {
                      phonenumber = phonenumber!;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        hintText: 'Enter your mobile phone',
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          color: Color.fromRGBO(123, 123, 123, 1),
                        ),
                        fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                        filled: true),
                  ),
                  SizedBox(height: 15.sp),
                  // end phonenumber form

                  // submit button
                  SizedBox(
                      width: double.infinity,
                      height: 7.h,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(primary)),
                          onPressed: () async {
                            print(place_type_selected);
                            print(province_selected);
                            print(phonenumber);
                            // if (formKey.currentState!.validate()) {
                            //   formKey.currentState?.save();
                            // ignore: unrelated_type_equality_checks
                            if (formKey.currentState!.validate()) {
                              storeBooking(
                                place_type_selected,
                                addressDetail,
                                province_selected,
                                phonenumber,
                              );
                            }

                            //   formKey.currentState?.reset();
                            // }
                          },
                          child: Text('add'))),
                  // end submit button
                ],
              ),
            ),
          ),
        )
      ]),
    );
    //     }
    // return Scaffold(
    //   body: Center(child: CircularProgressIndicator()),
    // );
  }
  // );
  // }
}
