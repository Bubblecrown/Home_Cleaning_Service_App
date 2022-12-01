import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/pages/BookingsList.dart';

class ReadBookings extends StatefulWidget {
  const ReadBookings({Key? key}) : super(key: key);

  @override
  State<ReadBookings> createState() => _ReadBookingsState();
}

class _ReadBookingsState extends State<ReadBookings> {
  @override
  Widget build(BuildContext context) {
    return BookingsList(FirebaseAuth.instance.currentUser!.uid);
  }
}
