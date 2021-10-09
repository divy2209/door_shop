import 'package:door_shop/screens/home.dart';
import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/provider_data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      Provider.of<CartData>(context, listen: false).retrieveCart();
      Provider.of<AddressData>(context, listen: false).store();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>HomeData(),
      child: Home(),
    );
  }
}
