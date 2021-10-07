import 'package:door_shop/services/database/order_data.dart';
import 'package:door_shop/services/models/order_model.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/order_widgets/orderlist.dart';
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
      body: StreamProvider<List<Order>>.value(
        value: OrderDatabase().ordersData,
        initialData: null,
        child: Padding(
          padding: EdgeInsets.only(right: 3),
          child: OrderList(),
        ),
      )
    );
  }
}
