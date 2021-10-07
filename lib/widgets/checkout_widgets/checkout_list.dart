import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartData>(context, listen: false);
    return Container(
      width: size.width*0.92,
      height: 55*cart.count>290 ? 290 : (60*cart.count).toDouble(),
      child: Scrollbar(
        thickness: 4,
        controller: _scrollController,
        radius: Radius.circular(5),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: cart.count,
          itemBuilder: (context, index){
            final CartCrop crop = cart.cart[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,),
              child: Row(
                children: [
                  Container(
                    width: size.width*0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(crop.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            SizedBox(width: size.width*0.02,),
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
                  SizedBox(width: size.width*0.058,),
                  Container(
                    width: 78,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('\u{20B9}' + (crop.price*crop.count).toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        SizedBox(width: size.width*0.02,)
                      ],
                    )
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
