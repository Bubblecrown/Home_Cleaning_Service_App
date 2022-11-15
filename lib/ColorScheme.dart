// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Color primary = Color(hexColor('#749BFA'));
Color Secondary =  Color(hexColor('#ACC4FF'));
Color white =  Color(hexColor('##FFFFFF'));
Color black =  Color(hexColor('#4F4F4F'));
Color greyPrimary =  Color(hexColor('#7B7B7B'));
Color grey =  Color(hexColor('#C0C0C0'));

Color yellow =  Color(hexColor('#eec045'));
Color green =  Color(hexColor('#4e9f7f'));
Color pinkSecondary =  Color(hexColor('#f4afc2'));
Color blueSecondary =  Color(hexColor('#a8bbf8'));
Color yellowSecondary =  Color(hexColor('#facc62'));


int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}