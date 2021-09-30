import 'package:door_shop/screens/checkout.dart';
import 'package:door_shop/screens/screens.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/database/user_data.dart';
import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  final double radius;
  final double width;
  final String label;
  final double height;
  final int index;
  final String type;
  final Crop crop;
  CartButton({@required this.type, @required this.radius, @required this.width, @required this.label, this.crop, this.height, this.index});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    final address = Provider.of<AddressData>(context, listen: false);
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      splashColor: Palette.primaryColor,
      onTap: () async{
        String showError;
        String showMessage;
        if(type==CartButtonIdentifier.home){
          int flag = cart.addToCart(crop);
          if(flag==1){

          } else if(flag==2){

          }
        } else if(type==CartButtonIdentifier.cartPlus){
          int flag = await cart.addCart(index);
          if(flag==1){

          } else if(flag==2){

          }
        } else if(type==CartButtonIdentifier.cartMinus){
          int flag = await cart.substractCart(index);
          if(flag==1){

          }
        } else if(type==CartButtonIdentifier.proceed){
          if(cart.count==0){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Add some Veggies to the cart first!"),
                  backgroundColor: Palette.primaryColor.withOpacity(0.5),
                  duration: Duration(seconds: 5),
                )
            );
          } else {
            address.store();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen())
            );
          }
        } else if(type==CartButtonIdentifier.order){
          showError = Validation().AddressValidation(
            address: address.address,
            city: address.city,
            state: address.state,
            pin: address.pin
          );
          if(showError==null){
            address.update();
            await UserDatabase().updateAddress(address: address.address, city: address.city, state: address.state, pin: address.pin);
            await cart.placeOrder();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context)=> Home()),
                (route) => false
            );
          }
        }

        if(showError!=null){
          ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(
              content: Text(showError),
              backgroundColor: Palette.primaryColor.withOpacity(0.4),
              duration: Duration(seconds: 5),
            )
          );
        }
      },
      child: Container(
        height: height!=null ? height : 25,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.primaryColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          //color: Palette.primaryColor.withOpacity(0.4)
        ),
        child: Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
