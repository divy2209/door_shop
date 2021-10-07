import 'package:connectivity/connectivity.dart';
import 'package:door_shop/services/connection.dart';
import 'package:door_shop/services/database/crop_data.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/database/order_data.dart';
import 'package:door_shop/services/models/order_model.dart';
import 'package:door_shop/widgets/home_widgets/croplist.dart';
import 'package:door_shop/widgets/order_widgets/orderlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkWrapper extends StatefulWidget {
  final Connection connection;
  final String screen;

  NetworkWrapper({@required this.connection, @required this.screen});

  @override
  _NetworkWrapperState createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.connection.disposeStreams();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>.value(
      value: widget.connection.networkStatusController.stream,
      initialData: null,
      child: Consumer<ConnectivityResult>(
        builder: (_,value,__){
          if(value==null){
            return Center(child: Text("Please check your Internet connection!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),));
          }
          if(value != ConnectivityResult.none){
            if(widget.screen=='home'){
              return StreamProvider<List<Crop>>.value(
                value: CropDatabase().cropsData,
                initialData: null,
                child: CropList(),
              );
            } else {
              return StreamProvider<List<Order>>.value(
                value: OrderDatabase().ordersData,
                initialData: null,
                child: OrderList(),
              );
            }
          }
          return Center(child: Text("Please connect to Internet!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),));
        },
      ),
    );
  }
}
