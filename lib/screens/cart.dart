import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/cart_widgets/cartlist.dart';
import 'package:door_shop/widgets/home_widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text('Veggie Basket'),
        centerTitle: true,
      ),
      body: Consumer<CartData>(
        builder: (_,__,___){
          return cart.count==0 ? Center(child: Text("Add some veggies to your diet!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)) : Padding(
            padding: const EdgeInsets.only(right: 3),
            child: CartList(),
          );
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
  }
}
