import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../config.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference profile = FirebaseFirestore.instance.collection('profiles');

  Future updateUserProfile({String name, int phone, String email, String url}) async {
    return await profile.doc(uid).set({
      'uid' : uid,
      'name': name,
      'phone number': phone,
      'email': email,
      'url' : url,
      'address': []
    });
  }

  Future updateAddress({List<String> completeAddress}) async {
    return await profile.doc(DoorShop.sharedPreferences.getString(DoorShop.userID)).update({
      'address': completeAddress
    });
  }

  Future upload(imageFile) async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(imageFileName);
    await reference.putFile(imageFile);
    String url = await reference.getDownloadURL();
    return url;
  }

  Future<void> localDataStorage() async {
    // todo: put the address part too
    if(uid != null) {
      profile.doc(uid).get().then((dataSnap) async {
        await DoorShop.sharedPreferences.setString(DoorShop.userID, dataSnap.get(DoorShop.userID));
        await DoorShop.sharedPreferences.setString(DoorShop.email, dataSnap.get(DoorShop.email));
        await DoorShop.sharedPreferences.setString(DoorShop.name, dataSnap.get(DoorShop.name));
        await DoorShop.sharedPreferences.setInt(DoorShop.phone, dataSnap.get(DoorShop.phone));
        await DoorShop.sharedPreferences.setString(DoorShop.url, dataSnap.get(DoorShop.url));
        String displayName = displayNameGenerator(DoorShop.sharedPreferences.getString(DoorShop.name));
        await DoorShop.sharedPreferences.setString(DoorShop.displayName, displayName);
        List<dynamic> address = await dataSnap.get(DoorShop.address);
        if(address.isNotEmpty){
          await DoorShop.sharedPreferences.setString(DoorShop.address, address[0]);
          await DoorShop.sharedPreferences.setString(DoorShop.city, address[1]);
          await DoorShop.sharedPreferences.setString(DoorShop.state, address[2]);
          await DoorShop.sharedPreferences.setInt(DoorShop.pin, int.tryParse(address[3]));
        }
      });
    }
  }

  String displayNameGenerator(String name){
    int n = name.length;
    int k = n;
    for(int i = 0; i<n; i++){
      if(name.substring(i,i+1)==" "){
        k = i;
        break;
      }
    }
    return name.substring(0,k);
  }
}