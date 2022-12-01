// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/data/reserveData.dart';
import 'package:sizer/sizer.dart';

class BookingsList extends StatefulWidget {
  final String documentId;

  BookingsList(this.documentId);

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('user_accounts');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Card(
                  child: ListTile(
                      title: Text("Battery Full"),
                      subtitle: Text("The battery is full."),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                      trailing: Icon(Icons.star))),
              Card(
                  child: ListTile(
                      title: Text("Anchor"),
                      subtitle: Text("Lower the anchor."),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                      trailing: Icon(Icons.star))),
              Card(
                  child: ListTile(
                      title: Text("Alarm"),
                      subtitle: Text("This is the time."),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                      trailing: Icon(Icons.star))),
              Card(
                  child: ListTile(
                      title: Text("Ballot"),
                      subtitle: Text("Cast your vote."),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                      trailing: Icon(Icons.star)))
            ],
          ));

          
        }

        return Text("loading");
      },
    );
  }
}

// Text("Full Name: ${data['username']} ${data['email']}");