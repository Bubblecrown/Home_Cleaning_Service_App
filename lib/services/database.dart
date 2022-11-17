import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference accountCollection =
      FirebaseFirestore.instance.collection('UserAccount');

  Future<void> updateUserData(
      String username, String email, String password ) async {
    return await accountCollection.doc(uid).set({
      'username' : username,
      'email': email,
      'password': password,
    });
  }
}
