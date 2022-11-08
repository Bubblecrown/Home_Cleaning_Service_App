import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String btnSignup = capitalize("continues with your account");
    String btnLogin = capitalize("create account");
    String title = capitalize("home hub");
    String description = "Keep your home clean and pristine by enlisting the help of a professional cleaner as often as you need.";
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/welcome/banner.png"),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(hexColor('#f36b7f')),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(hexColor('#7a7a7a')),
                  fontSize: 14,
      
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(hexColor('#f36b7f'))),
                    onPressed: () {},
                    child: Text(btnSignup)),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Color(hexColor('#f36b7f'))),
                    onPressed: () {},
                    child: Text(btnLogin)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String capitalize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}
