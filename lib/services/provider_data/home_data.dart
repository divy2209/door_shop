import 'package:flutter/material.dart';

class HomeData extends ChangeNotifier{
  String name;

  void search(String value){
    name = value;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}