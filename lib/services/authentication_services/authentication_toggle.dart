import 'package:door_shop/screens/screens.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showLogin = true;
  void toggleView(){
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin){
      return LoginPage(toggleView: toggleView);
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}