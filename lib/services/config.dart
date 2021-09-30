import 'package:shared_preferences/shared_preferences.dart';

class DoorShop {
  static SharedPreferences sharedPreferences;

  static final String userProfile = 'profile';

  static final String name = 'name';
  static final String userID = 'uid';
  static final String email = 'email';
  static final String phone = 'phone number';
  static final String url = 'url';
  static final String address = 'address';
  static final String city = 'city';
  static final String state = 'state';
  static final String pin = 'pin code';
}

class FormIdentifier {
  static final String login = 'login form';
  static final String register = 'register form';
}

class TextFieldHint {
  static final String email = 'Email';
  static final String password = 'Password';
  static final String phone = 'Phone Number';
  static final String name = 'Full Name';
  static final String confirmPassword = 'Confirm Password';
}

class CartButtonIdentifier {
  static final String home = 'adding to cart';
  static final String cartPlus = 'increase';
  static final String cartMinus = 'decrease';
  static final String proceed = 'proceed to checkout';
  static final String order = 'place order';
}

class AddressFieldHint {
  static final String address = 'Address';
  static final String city = 'City';
  static final String state = 'State';
  static final String pin = 'Pin Code';
}