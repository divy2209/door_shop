import 'dart:io';

import 'package:door_shop/services/config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterData extends ChangeNotifier{
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool running = false;
  bool loading = false;

  void register(String str, String hint){
    if(hint == TextFieldHint.name){
      name = str;
    } else if(hint == TextFieldHint.phone){
      phone = str;
    } else if(hint == TextFieldHint.email){
      email = str;
    } else if(hint == TextFieldHint.password){
      password = str;
    } else{
      confirmPassword = str;
    }

    notifyListeners();
  }

  void clearPasswords(){
    passwordController.clear();
    confirmPasswordController.clear();

    password = null;
    confirmPassword = null;

    notifyListeners();
  }


  File imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }

  void processRunning(){
    running = !running;
    notifyListeners();
  }

  void buttonLoading(){
    loading=!loading;
    notifyListeners();
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}