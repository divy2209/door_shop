import 'package:flutter/material.dart';

class Validation{

  String phoneValidation({@required value}) {
    String pattern = r'(^[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Please enter a valid mobile number';
    } else {
      return null;
    }
  }

  String nameValidation({@required value}) {
    String pattern = r'(^\s*([A-Za-z]{1,}([\.] |[ ]| ))*[A-Za-z]+\.?\s*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length < 3) {
      return 'Please enter a valid name';
    } else if(!regExp.hasMatch(value)){
      return 'Please enter a valid name';
    } else {
      return null;
    }
  }

  String emailValidation({@required value}) {
    String pattern = r'(^[a-z0-9]+([-+._][a-z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2}$)';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  String passwordValidation({@required value}) {
    String pattern = r'(^\S{8,}$)';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Please enter a valid password';
    } else {
      return null;
    }
  }

  String confirmPasswordValidation({@required password, @required value}) {
    if (value == password) {
      return null;
    } else {
      return 'Passwords does not match';
    }
  }
}

class CredentialValidation {
  String loginValidation ({@required email/*phone*/, @required password}) {
    String emailError = Validation().emailValidation(value: email ?? '');
    //String phoneError = Validation().phoneValidation(value: phoneNumber.toString() ?? '');
    String passwordError = Validation().passwordValidation(value: password ?? '');

    if(emailError/*phoneError*/ == null && passwordError == null) {
      return null;
    } else if(emailError/*phoneError*/ != null) {
      return emailError/*phoneNumber*/;
    } else {
      return passwordError;
    }
  }

  String registerValidation ({@required name, @required phone, @required email, @required password, @required confirmPassword}) {
    String nameError = Validation().nameValidation(value: name ?? '');
    String phoneError = Validation().phoneValidation(value: phone.toString() ?? '');
    String emailError = Validation().emailValidation(value: email ?? '');
    String passwordError = Validation().passwordValidation(value: password ?? '');
    String confirmError = Validation().confirmPasswordValidation(password: password ?? '', value: confirmPassword ?? '');

    if (nameError == null && phoneError == null && emailError == null && passwordError == null && confirmError == null) {
      return null;
    } else if(nameError != null){
      return nameError;
    } else if(phoneError != null){
      return phoneError;
    } else if(emailError != null){
      return emailError;
    } else if(passwordError != null){
      return passwordError;
    } else{
      return confirmError;
    }
  }

  String forgotPasswordValidation ({@required phone}) {
    String phoneError = Validation().phoneValidation(value: phone.toString() ?? '');

    if(phoneError == null) {
      return null;
    } else {
      return phoneError;
    }
  }
}