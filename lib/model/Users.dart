// ignore_for_file: file_names

class UserID {

  String uid;
  
  UserID({ required this.uid });

}

class Users{
  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  Users({required this.uid,required this.firstName,required this.lastName,required this.email, required this.password, required this.confirmPassword});
}
// required this.uid