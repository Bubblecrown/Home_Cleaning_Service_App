// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/pages/Booking.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/shared/font.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class BookingsList extends StatefulWidget {
  final String documentId;

  BookingsList(this.documentId);

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference booking =
        FirebaseFirestore.instance.collection('booking_list');

    return FutureBuilder<Object>(
        future: booking
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            final Timestamp time = snapshot.data!['booking_time'] as Timestamp;
            final DateTime dateTime = time.toDate();
            final dateSet = DateFormat("yyyy-MM-dd' | 'HH:mm").format(dateTime);

            return Scaffold(
              backgroundColor: bgBlueWhite,
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'CLEANING',
                                        style: TextStyle(
                                          fontFamily: TextCustom.subBold,
                                          fontSize: 16.sp,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.date_range_outlined)),
                                    TextSpan(
                                        text: ' ${dateSet}',
                                        style: TextStyle(
                                          fontFamily: TextCustom.desRegular,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.apartment_outlined)),
                                    TextSpan(
                                        text:
                                            ' ${snapshot.data!['place_type'] ?? 0}',
                                        style: TextStyle(
                                          fontFamily: TextCustom.desRegular,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.timer_outlined)),
                                    TextSpan(
                                        text:
                                            ' ${snapshot.data!['duration_selected'] ?? 0}',
                                        style: TextStyle(
                                          fontFamily: TextCustom.desRegular,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child:
                                            Icon(Icons.price_change_outlined)),
                                    TextSpan(
                                        text:
                                            ' ${snapshot.data!['total_price'] ?? 0}',
                                        style: TextStyle(
                                          fontFamily: TextCustom.desRegular,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.home_outlined)),
                                    TextSpan(
                                        text:
                                            ' ${snapshot.data!['Address'] ?? 0} ',
                                        style: TextStyle(
                                          fontFamily: TextCustom.desRegular,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: greyPrimary,
                    size: 30.w,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "No Booking, yet",
                    style: TextStyle(
                        fontFamily: TextCustom.desRegular, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                      width: 45.w,
                      height: 6.h,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(primary)),
                          onPressed: () async {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return BookingPage();
                            }));
                          },
                          child: Text(
                            'Book a service',
                            style: TextStyle(
                                fontFamily: TextCustom.desRegular,
                                fontSize: 14.sp),
                          ))),
                ],
              ),
            );
          }
        });
  }
}
