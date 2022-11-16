// ignore_for_file: file_names

class ReserveData {
  static var title = capitalize("cleanon.");
  static var header = capitalize("Hello!");
  static var description = "Create your account ";
  static var btnSignup = "sign up".toUpperCase();
  static var image = "assets/image/bannerAccount.png";
  static var success = capitalize("your account has been successfully created");

  // email
  static var emailFormatError = "You must enter a valid email address.";
  static var emailCheckBlank = "You must enter your email.";
  // end email

}

String capitalize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
