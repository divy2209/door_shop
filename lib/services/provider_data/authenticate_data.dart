import 'package:flutter/material.dart';

class AuthenticatingData extends ChangeNotifier{
  bool f = true;

  void flag(){
    f=!f;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}