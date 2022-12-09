// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Color primary = Color(hexColor('#749BFA'));
Color Secondary = Color(hexColor('#ACC4FF'));
Color white = Color(hexColor('#FFFFFF'));
Color whiteSecondary = Color(hexColor('#E3EBFF'));
Color black = Color(hexColor('#4F4F4F'));
Color greyPrimary = Color(hexColor('#7B7B7B'));
Color grey = Color(hexColor('#C0C0C0'));
Color bgWhite = Color(hexColor('#F8FAFF'));
Color bgBlueWhite = Color(hexColor('#F1F5FE'));
Color bgBlue = Color.fromRGBO(156, 185, 255, 1);
Color logout = Color.fromARGB(255, 255, 156, 168);

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}
