import 'package:flutter/material.dart';

class AuthenticatingData extends ChangeNotifier{
  bool pageloading = false;
  // Todo:different bools for different loading
  void pageLoading(){
    pageloading = !pageloading;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}