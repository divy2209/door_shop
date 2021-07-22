import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/database/user_data.dart';
import 'package:door_shop/services/authentication_services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// TODO: Firebase error handelling
class AuthorizationService{
  final FirebaseAuth _authorization = FirebaseAuth.instance;

  DoorShopID _userFromFirebase(User user){
    return user != null ? DoorShopID(uid: user.uid) : null;
  }

  Stream<DoorShopID> get user {
    return _authorization.authStateChanges().map((_userFromFirebase));
  }

  Future login({@required String email, @required String password}) async {
    try {
      UserCredential result = await _authorization.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      UserDatabase(uid: user.uid).localDataStorage();

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
        email: email,
      );

      UserDatabase(uid: user.uid).localDataStorage();

      return _userFromFirebase(user);

    } catch(e) {
      return e.hashCode;
    }
  }

  Future signOutApp() async {
    try {
      await DoorShop.sharedPreferences.clear();
      return await _authorization.signOut();
    } catch(e) {
      return null;
    }
  }
}