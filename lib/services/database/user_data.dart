import 'package:cloud_firestore/cloud_firestore.dart';

import '../config.dart';

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

  Future<void> localDataStorage() async {
    print(uid);
    if(uid != null) {
      profile.doc(uid).get().then((dataSnap) async {
        await DoorShop.sharedPreferences.setString(DoorShop.userID, dataSnap.get(DoorShop.userID));
        await DoorShop.sharedPreferences.setString(DoorShop.email, dataSnap.get(DoorShop.email));
        await DoorShop.sharedPreferences.setString(DoorShop.name, dataSnap.get(DoorShop.name));
        await DoorShop.sharedPreferences.setInt(DoorShop.phone, dataSnap.get(DoorShop.phone));
      });
    }
  }
}