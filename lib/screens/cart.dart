import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/provider_data/authenticate_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/cart_widgets/cartlist.dart';
import 'package:door_shop/widgets/drawer.dart';
import 'package:door_shop/widgets/home_widgets/cart_button.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return Consumer<AuthenticatingData>(
      builder: (_,authenticate,__){
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
          body: Consumer<CartData>(
            builder: (_,__,___){
              return cart.count==0 ? Center(child: Text("How about adding some veggies to your diet!")) : CartList();
            },
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 20,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Text("Total:  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Consumer<CartData>(
                    builder: (_,__,___){
                      return Text('\u{20B9}' + cart.gtotal.toString() + "/-", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),);
                    },
                  ),
                  Spacer(flex: 3,),
                  CartButton(
                    radius: 10,
                    width: 162,
                    height: 30,
                    label: "Proceed to Checkout",
                    type: CartButtonIdentifier.proceed,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
