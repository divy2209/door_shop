import 'package:flutter/material.dart';

import '../config.dart';

class LoginData extends ChangeNotifier {
  String email;
  String password;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(String str, String hint){
    if(hint == TextFieldHint.email){
      email = str;
    } else if(hint == TextFieldHint.password){
      password = str;
    }
    notifyListeners();
  }

  void clearPass(){
    passwordController.clear();
    password = null;
    notifyListeners();
  }


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}