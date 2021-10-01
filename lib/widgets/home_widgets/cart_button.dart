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
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      splashColor: !cart.running ? Palette.primaryColor : Colors.white,

      onTap: () async{
        String showError;
        String showMessage;
        String message;

        if(type==CartButtonIdentifier.home){
          int flag = cart.addToCart(crop);
          if(flag==1){
            showMessage = "Inventory Limit!";
            message = "This is the limiting quantity for this vegetable, we're working to increase the inventory";
          } else if(flag==2){
            showMessage = "Inventory Exceeded!";
            message = "The cart quantity is been reset due to inventory exceeding";
          }
        } else if(type==CartButtonIdentifier.cartPlus){
          int flag = await cart.addCart(index);
          if(flag==1){
            showMessage = "Inventory Limit!";
            message = "This is the limiting quantity for this vegetable, we're working to increase the inventory";
          } else if(flag==2){
            showMessage = "Inventory Exceeded!";
            message = "The cart quantity is been reset due to inventory exceeding, we're working to increase the inventory";
          }
        } else if(type==CartButtonIdentifier.cartMinus){
          int flag = await cart.substractCart(index);
          if(flag==1){
            showMessage = "Inventory Exceeded!";
            message = "The cart quantity is been reset due to inventory exceeding, we're working to increase the inventory";
          }
        } else if(type==CartButtonIdentifier.proceed){
          if(cart.count==0){
            showError = "Add some Veggies to the cart first!";
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen())
            );
          }
        } else if(type==CartButtonIdentifier.order && !cart.running){
          cart.processRunning();
          showError = Validation().AddressValidation(
            address: address.address,
            city: address.city,
            state: address.state,
            pin: address.pin
          );
          if(showError==null){
            cart.buttonLoading();
            address.update();
            await UserDatabase().updateAddress(completeAddress: address.completeAddress);
            int amount = await cart.placeOrder(address.completeAddress);
            cart.buttonLoading();
            showMessage = "Order Placed!";
            message = "Your order has been placed, please pay " + '\u{20B9}' + "$amount on delivery";
          }
          cart.processRunning();
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

        if(showMessage!=null && message!=null){
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(showMessage),
              content: Text(message),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Center(
                    child: TextButton(
                      child: Container(
                        width: 200,
                        child: Center(
                           child: Text('Okay'),
                        ),
                      ),
                      onPressed: (){
                        if(type==CartButtonIdentifier.order){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context)=> Home()),
                                  (route) => false
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
              ],
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
        ),
        child: Center(
          child: !cart.loading ? Text(label, style: TextStyle(fontWeight: FontWeight.bold),) :
            SpinKitThreeBounce(
              color: Palette.primaryColor,
              size: 20,
            )
        ),
      ),
    );
  }
}
