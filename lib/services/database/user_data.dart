import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference profile = FirebaseFirestore.instance.collection('profiles');

  Future updateUserProfile({String name, int phone, String email}) async {
    return await profile.doc(uid).set({
      'uid' : uid,
      'name': name,
      'phone number': phone,
      'email': email
    });
  }
}

class LocalDatabase {
  static final String name = 'name';
  static final String email = 'email';
  static final String userID = 'uid';
  static final String phone = 'phone';
}