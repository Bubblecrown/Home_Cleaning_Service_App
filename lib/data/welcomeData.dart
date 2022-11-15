// ignore_for_file: file_names

class WelcomeData {
  static var subtitle = capitalize("cleanon.");
  static var title = capitalize("welcome!");
  static var description =
      "Welcome to cleaning of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
  static var textHyperlink = "Didn’t have any account ?";
  static var btnSignup = "signup".toUpperCase();
  static var btnLogin = "sign in".toUpperCase();
  static var image = "assets/image/banner.png";
}

String capitalize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
