import 'package:door_shop/screens/cart.dart';
import 'package:door_shop/services/database/crop_data.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/provider_data/authenticate_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/drawer.dart';
import 'package:door_shop/widgets/home_widgets/croplist.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: Add refresh functionality to update the pricing

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticatingData>(
      builder: (context, authenticate, child){
        return authenticate.pageloading ? Loading() : Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.primaryColor,
              elevation: 0,
              title: Center(child: Text('Door Shop')),
              centerTitle: true,
              actions: [
                Container(
                  height: 150,
                  width: 50,
                  child: Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartScreen())
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 45,
                            child: Icon(Icons.shopping_cart)
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 9,
                            backgroundColor: Colors.red,
                            child: Consumer<CartData>(
                              builder: (_,cart,___){
                                return Text(cart.count.toString(), style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),);
                              },
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            drawer: CustomDrawer(),
            body: StreamProvider<List<Crop>>.value(
              value: CropDatabase().cropsData,
              initialData: null,
              child: CropList(),
            )
        );
      },
    );
  }
}
