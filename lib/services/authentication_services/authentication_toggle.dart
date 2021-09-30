import 'package:door_shop/screens/screens.dart';
import 'package:door_shop/services/provider_data/login_data.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      return ChangeNotifierProvider(
        create: (_) => LoginData(),
        child: LoginPage(toggleView: toggleView),
      );
    } else {
      return ChangeNotifierProvider(
        create: (_) => RegisterData(),
        child: RegisterPage(toggleView: toggleView),
      );
    }
  }
}