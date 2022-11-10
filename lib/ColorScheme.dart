

import 'package:flutter/material.dart';

Color pink = Color(hexColor('#f36b7f'));
Color blue =  Color(hexColor('#3b7fcf'));
Color yellow =  Color(hexColor('#eec045'));
Color green =  Color(hexColor('#4e9f7f'));
Color pinkSecondary =  Color(hexColor('#f4afc2'));
Color blueSecondary =  Color(hexColor('#a8bbf8'));
Color yellowSecondary =  Color(hexColor('#facc62'));
Color bg =  Color(hexColor('#eeffff'));
Color textSecondary =  Color(hexColor('#7a7a7a'));

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}