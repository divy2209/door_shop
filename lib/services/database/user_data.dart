import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference profile = FirebaseFirestore.instance.collection('profiles');

  Future updateUserProfile({String name, int phone, String email}) async {
    return await profile.doc(uid).set({
      'name': name,
      'phone number': phone,
      'email': email
    });
  }
}

class LocalDatabase {

}