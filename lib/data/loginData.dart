// ignore_for_file: file_names

class LoginData {
  static var title = capitalize("cleanon.");
  static var header = capitalize("Welcome, back");
  static var description = "Sign in to your account ";
  static var btnLogin = "login".toUpperCase();
  static var image = "assets/image/bannerAccount.png";
}

String capitalize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
