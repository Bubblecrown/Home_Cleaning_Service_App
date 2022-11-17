// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final List<String> province = [
    'Condo 1 BR (40 sq.m.)',
    'Condo 1 BR (50 sq.m.)',
    'Condo 2 BR (80 sq.m.)',
    'Condo 3 BR (100 sq.m.)',
    'House 1 Story (100 sq.m.)',
    'House 2-3 Stories (100-200 sq.m.)',
    'House (> 200 sq.m.)',
    'Office/ Workplace'
  ];

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
  String place_type_selected = '';
  String remark = '';
  String address = '';
  late int phonenumber;
  // end form value

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
          padding: EdgeInsets.all(30.sp),
          width: 100.w,
          height: 75.h,
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

                // label
                Text('Place Name'),
                SizedBox(height: 10.sp),
                // end label

                // place name form
                TextFormField(
                  style: TextStyle(color: greyPrimary),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a Place Name' : null,
                  onChanged: (val) => setState(() => place_name = val),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      hintText: 'e.g. My home / My condo / Office',
                      prefixIcon: Icon(
                        Icons.home_outlined,
                        color: Color.fromRGBO(123, 123, 123, 1),
                      ),
                      fillColor: Color.fromRGBO(192, 192, 192, 0.20),
                      filled: true),
                ),
                SizedBox(height: 15.sp),
                // end email form

                // label
                Text('Place Type'),
                SizedBox(height: 10.sp),
                // end label

                // dropdown
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: place_type.first,
                  decoration: InputDecorationCustom,
                  items: place_type.map((choice) {
                    return DropdownMenuItem(
                      value: choice,
                      child: Text('$choice'),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      setState(() => place_type_selected = val!),
                ),
                // end dropdown

                SizedBox(height: 15.sp),

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
                          print(place_name);
                          print(place_type_selected);
                        },
                        child: Text('add'))),
                // end submit button
              ],
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
