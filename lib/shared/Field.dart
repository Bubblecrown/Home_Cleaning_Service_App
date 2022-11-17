// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const InputDecorationCustom = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(30))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(30))),
    contentPadding: EdgeInsets.all(20),
    // prefixIcon: Icon(
    //   Icons.home_outlined,
    //   color: Color.fromRGBO(123, 123, 123, 1),
    // ),
    fillColor: Color.fromRGBO(192, 192, 192, 0.20),
    filled: true);
