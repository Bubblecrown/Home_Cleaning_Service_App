// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/pages/MapLocationPage.dart';
import 'package:home_cleaning_service_app/shared/Field.dart';
import 'package:home_cleaning_service_app/shared/font.dart';
import 'package:home_cleaning_service_app/shared/NavigationBar.dart';

import 'package:sizer/sizer.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _LocaBookingState();
}

class _LocaBookingState extends State<BookingPage> {
  final formKey = GlobalKey<FormState>();

  final List<String> place_type = [
    'Condo 1-2 BR (40-80 sq.m.)',
    'Condo 3 BR (100 sq.m.)',
    'House 1-3 Stories (100-200 sq.m.)',
    'House (> 200 sq.m.)'
  ];

  final List<String> province = [
    'Bangkok',
    'Chonburi',
    'Pathum Thani',
    'Chiang Mai',
  ];

  final List<String> duration = [
    '2 hr.',
    '3 hr.',
    '4 hr.',
    '5 hr.',
    '6 hr.',
    '8 hr.',
  ];

  // form value
  String place_type_selected = '';
  String address = '';
  String province_selected = '';
  String district = '';
  String addressDetail = '';
  String phonenumber = '';
  String duration_selected = '';
  String additional = '';
  // end form value

  DateTime dateTime = DateTime.now();
  void storeBooking(
      String place_type_selected,
      String duration_selected,
      String province_selected,
      String addressDetail,
      String phonenumber,
      DateTime dateTime,
      String additional,
      int total) async {
    await FirebaseFirestore.instance
        .collection('booking_list')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'place_type': place_type_selected,
      'duration_selected': duration_selected,
      'province': province_selected,
      'address_detail': addressDetail,
      'phone_number': phonenumber,
      'booking_time': dateTime,
      'additional': additional,
      'total_price': total
    });
  }

  var total;
  void priceCalculate(
      place_type_selected, province_selected, duration_selected) {
    var placeTypePrice;
    var provincePrice;
    var hourPrice;

    if (place_type_selected == 'Condo 1-2 BR (40-80 sq.m.)') {
      placeTypePrice = 150;
    } else if (place_type_selected == 'Condo 3 BR (100 sq.m.)') {
      placeTypePrice = 225;
    } else if (place_type_selected == 'House 1-3 Stories (100-200 sq.m.)') {
      placeTypePrice = 300;
    } else if (place_type_selected == 'House (> 200 sq.m.)') {
      placeTypePrice = 350;
    }
    // 500
    if (province_selected == 'Bangkok' || province_selected == 'Chonburi') {
      provincePrice = 120;
    } else if (province_selected == 'Pathum Thani') {
      provincePrice = 100;
    } else if (province_selected == 'Chiang Mai') {
      provincePrice = 80;
    }

    if (duration_selected == '2 hr.') {
      hourPrice = 150;
    } else if (duration_selected == '3 hr.') {
      hourPrice = 300;
    } else if (duration_selected == '4 hr.') {
      hourPrice = 450;
    } else if (duration_selected == '5 hr.') {
      hourPrice = 600;
    } else if (duration_selected == '6 hr.') {
      hourPrice = 750;
    } else if (duration_selected == '8 hr.') {
      hourPrice = 900;
    }
    total = placeTypePrice + provincePrice + hourPrice;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
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
        iconTheme: IconThemeData(color: greyPrimary),
        leading: BackButton(onPressed: (() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return NavigationBarBtn();
          }));
        })),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // end appbar

      body: ListView(children: [
        Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          width: 100.w,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30.sp, 0, 30.sp, 30.sp),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    'Book a Service',
                    style: TextStyle(
                        fontSize: 24.sp, fontFamily: TextCustom.desBold),
                  ),
                  // end title
                  SizedBox(height: 15.sp),

                  // Map label
                  Text('Location (optional)'),
                  SizedBox(height: 10.sp),
                  // end Map label

                  // Map form
                  SizedBox(
                      width: double.infinity,
                      height: 7.h,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(242, 242, 242, 1))),
                          onPressed: () async {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return MapLocationPage();
                            }));
                          },
                          child: Text('Add your location',
                              style: TextStyle(color: greyPrimary)))),
                  SizedBox(height: 15.sp),
                  // end map form

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
                  Text('Address Detail (optional)'),
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
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        filled: true),
                  ),
                  SizedBox(height: 15.sp),
                  // end address detail form

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
                          Icons.phone_android_outlined,
                          color: Color.fromRGBO(123, 123, 123, 1),
                        ),
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        filled: true),
                  ),
                  SizedBox(height: 15.sp),
                  // end phonenumber form

                  // label
                  Text('Cleaning Duration'),
                  SizedBox(height: 10.sp),
                  // end label

                  // duration dropdown
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text('Select Duration'),
                    value: null,
                    validator: (value) => value == null
                        ? 'You should select cleaning duration.'
                        : null,
                    decoration: InputDecorationCustom,
                    items: duration.map((choice) {
                      return DropdownMenuItem(
                        value: choice,
                        child: Text('$choice'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => duration_selected = val!),
                    onSaved: (String? duration_selected) {
                      duration_selected = duration_selected!;
                    },
                  ),
                  SizedBox(height: 15.sp),

                  // end duration dropdown

                  // Date Time label
                  Text('When do you need this service?'),
                  SizedBox(height: 10.sp),
                  // end label

                  // Date form
                  Row(
                    children: [
                      SizedBox(
                          width: 38.w,
                          height: 7.h,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(242, 242, 242, 1))),
                              onPressed: () async {
                                final date = await pickDate();
                                if (date == null) return;

                                final newDateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    dateTime.hour,
                                    dateTime.minute);
                                setState(() => dateTime = newDateTime);
                              },
                              child: Text(
                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                                  style: TextStyle(color: greyPrimary)))),
                      // end Date form
                      Spacer(),
                      // Time form
                      SizedBox(
                          width: 38.w,
                          height: 7.h,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(242, 242, 242, 1)),
                              ),
                              onPressed: () async {
                                final time = await pickTime();
                                if (time == null) return;
                                final newDateTime = DateTime(
                                    dateTime.year,
                                    dateTime.month,
                                    dateTime.day,
                                    time.hour,
                                    time.minute);
                                setState(() => dateTime = newDateTime);
                              },
                              child: Text(
                                '${dateTime.hour}:${dateTime.minute}',
                                style: TextStyle(color: greyPrimary),
                              ))),
                    ],
                  ),
                  SizedBox(height: 15.sp),
                  // end Time form

                  // label
                  Text('Additional Detail (optional)'),
                  SizedBox(height: 10.sp),
                  // end label

                  // address detail form
                  TextFormField(
                    style: TextStyle(color: greyPrimary),
                    // validator: (val) =>
                    //     val!.isEmpty ? 'Please enter a Place Name' : null,
                    onChanged: (val) => setState(() => additional = val),
                    onSaved: (String? additional) {
                      additional = additional!;
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
                        hintText: 'e.g. Owned a pet, Covid patient',
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          color: Color.fromRGBO(123, 123, 123, 1),
                        ),
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        filled: true),
                  ),
                  SizedBox(height: 15.sp),
                  // end address detail form

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
                            priceCalculate(place_type_selected,
                                province_selected, duration_selected);
                            print(total);

                            if (formKey.currentState!.validate()) {
                              storeBooking(
                                  place_type_selected,
                                  duration_selected,
                                  province_selected,
                                  addressDetail,
                                  phonenumber,
                                  dateTime,
                                  additional,
                                  total);
                              formKey.currentState?.reset();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return NavigationBarBtn();
                              }));
                            }
                          },
                          child: Text('CONFIRM'))),
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
