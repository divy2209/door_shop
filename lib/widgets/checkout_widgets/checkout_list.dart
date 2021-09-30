import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return Container(
      width: 450,
      height: 55*cart.count>290 ? 290 : (55*cart.count).toDouble(),
      child: ListView.builder(
        itemCount: cart.count,
        itemBuilder: (context, index){
          final CartCrop crop = cart.cart[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(crop.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Text(crop.unit + "  " + '\u{20B9}' + crop.price.toString(), style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  child: Center(child: Text(crop.count.toString(), style: TextStyle(fontSize: 14),)),
                ),
                SizedBox(width: 20,),
                Text('\u{20B9}' + (crop.price*crop.count).toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              ],
            ),
          );
        },
      ),
    );
  }
}
