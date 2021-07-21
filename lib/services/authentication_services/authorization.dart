import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_shop/services/database/user_data.dart';
import 'package:door_shop/services/authentication_services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// TODO: Firebase error handelling
class AuthorizationService{
  final FirebaseAuth _authorization = FirebaseAuth.instance;

  DoorShopID _userFromFirebase(User user){
    if(_userFromFirebase(user) != null) {
      FirebaseFirestore.instance.collection('profile').doc(user.uid).get().then((dataSnap) async{
        await DoorShop.sharedPreferences.setString(LocalDatabase.userID, dataSnap.get('uid'));
        await DoorShop.sharedPreferences.setString(LocalDatabase.email, dataSnap.get('email'));
        await DoorShop.sharedPreferences.setString(LocalDatabase.name, dataSnap.get('name'));
        await DoorShop.sharedPreferences.setInt(LocalDatabase.phone, dataSnap.get('phone'));
      });
    }
    return user != null ? DoorShopID(uid: user.uid) : null;
  }

  Stream<DoorShopID> get user {
    return _authorization.authStateChanges().map((_userFromFirebase));
  }

  Future login({@required String email, @required String password}) async {
    try {
      UserCredential result = await _authorization.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);

    } catch (e) {
      return e.hashCode;
    }
  }

  Future register({@required String name, @required int phone, @required String email, @required String password}) async {
    try {
      UserCredential result = await _authorization.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await UserDatabase(uid: user.uid).updateUserProfile(
        name: name,
        phone: phone,
        email: email
      );
      return _userFromFirebase(user);

    } catch(e) {
      return e.hashCode;
    }
  }

  Future signOutApp() async {
    try {
      DoorShop.sharedPreferences.clear();
      return await _authorization.signOut();
    } catch(e) {
      //print(e.toString());
      return null;
    }
  }
}