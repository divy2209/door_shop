import 'package:shared_preferences/shared_preferences.dart';

class DoorShopID{
  DoorShopID({this.uid});
  final String uid;
}

class DoorShop {
  static SharedPreferences sharedPreferences;
}