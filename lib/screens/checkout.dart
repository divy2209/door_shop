import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/checkout_widgets/address_display.dart';
import 'package:door_shop/widgets/checkout_widgets/checkout_list.dart';
import 'package:door_shop/widgets/home_widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text("Checkout"),
        centerTitle: true,
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
              Consumer<CartData>(
                builder: (_,__,___){
                  return CartButton(
                    radius: 10,
                    width: 162,
                    height: 30,
                    label: "Place Order",
                    type: CartButtonIdentifier.order,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckoutList(),
                SizedBox(height: 12,),
                Divider(color: Colors.grey, thickness: 1,),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Subtotal", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 5,),
                        Text("Discount", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20,),
                        Text("Total")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\u{20B9}' + cart.total.toString(), style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 5,),
                        Text('- ' + '\u{20B9}' + (cart.total-cart.gtotal).toString(), style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 20,),
                        Text('\u{20B9}' + cart.gtotal.toString())
                      ],
                    )
                  ],
                ),
                SizedBox(height: 80,),
                Text("Shipping Address", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                SizedBox(height: 12,),
                Divider(color: Colors.grey, thickness: 1,),
                SizedBox(height: 12,),
                AddressDisplay(),
                SizedBox(height: 52,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
