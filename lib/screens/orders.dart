import 'package:door_shop/services/connection.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/network_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: Provider<Connection>(
        create: (context) => Connection(),
        child: Consumer<Connection>(
          builder: (context, value, _){
            return NetworkWrapper(connection: value, screen: 'order');
          },
        ),
      )
    );
  }
}
