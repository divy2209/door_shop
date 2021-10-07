import 'package:door_shop/screens/home.dart';
import 'package:door_shop/services/authentication_services/authentication_toggle.dart';
import 'package:door_shop/services/authentication_services/user.dart';
import 'package:door_shop/services/provider_data/authenticate_data.dart';
import 'package:door_shop/widgets/home_widgets/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<DoorShopID>(context);
    final authenticate = Provider.of<AuthenticatingData>(context, listen: false);
  // TODO: if there's an error at register page, will that be taking us back to login page, if yes then change this into toggle switch
    if(userData == null){
      return AuthenticationPage();
    } else{
      if(authenticate.f) return HomeWrapper();
      else return Home();
    }
  }
}