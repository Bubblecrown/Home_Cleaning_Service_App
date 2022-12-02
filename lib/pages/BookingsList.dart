// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/reserveData.dart';
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
  DateTime? booking_time;
  String? place_type;
  String? duration_selected;
  int? total_price;
  String? address;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser?.uid;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("booking_list")
          .doc(firebaseUser)
          .get()
          .then((ds) {
        setState(() {
          booking_time = ds.data()?["booking_time"];
          place_type = ds.data()?["place_type"];
          duration_selected = ds.data()?["duration_selected"];
          total_price = ds.data()?["total_price"];
          address = ds.data()?["address"];
        });

        print(booking_time);
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> cancel(String jobId) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('jobs')
        .doc(firebaseUser)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference booking =
        FirebaseFirestore.instance.collection('booking_list');

    return FutureBuilder<Object>(
        future: booking.doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, AsyncSnapshot snapshot) {
          final Timestamp time = snapshot.data!['booking_time'] as Timestamp;
          final DateTime dateTime = time.toDate();
          final dateString =
              DateFormat("yyyy-MM-dd' | 'HH:mm").format(dateTime);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
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
                                      text: ' ${dateString}',
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
                                  WidgetSpan(child: Icon(Icons.timer_outlined)),
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
                                      child: Icon(Icons.price_change_outlined)),
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
                                  WidgetSpan(child: Icon(Icons.home_outlined)),
                                  TextSpan(
                                      text:
                                          ' ${snapshot.data!['address'] ?? 0}',
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
        });
  }
}



// FutureBuilder<Object>(
//         future: booking.doc(FirebaseAuth.instance.currentUser?.uid).get(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading...");
//           }
//           return Scaffold(
//             backgroundColor: bgBlueWhite,
//             body: 
            
//             ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Container(
//                     height: 20.h,
//                     color: white,
//                     child: Text("${snapshot.data!['address'] ?? 0}")),
//                 ),
//               ],
//             ),
//           );
//         });


// Scaffold(
          //   body: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: ListView(
          //       children: snapshot.data?.docs.map((doc) {
          //             // your widget here(use doc data)
          //             return Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Container(
          //                 height: 20.h,
          //                 color: grey,
          //                 child: Column(
          //                   children: [Text("${doc.data()}")],
          //                 ),
          //               ),
          //             );
          //           }).toList() ??
          //           [],
          //     ),
          //   ),
          // );

// Text("Full Name: ${data['username']} ${data['email']}");

// FutureBuilder<DocumentSnapshot>(
//       future: users.doc(widget.documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Scaffold(
//               body: ListView(
//             padding: const EdgeInsets.all(8),
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(),
//               )
//             ],
//           ));
//         }

//         return Text("loading");
//       },
//     );