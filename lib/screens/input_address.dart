import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/services/database/user_data.dart';
import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/checkout_widgets/address_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Address extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final address = Provider.of<AddressData>(context, listen: false);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primaryColor,
          elevation: 0,
          title: Text('Address'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, top: 30),
          child: Column(
            children: [
              AddressForm(),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<AddressData>(
                    builder: (_,address,__){
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: !address.running ? Palette.primaryColor : Colors.white,
                        onTap: !address.running ? ()async{
                          address.processRunning();
                          String showError = Validation().AddressValidation(
                            address: address.address,
                            city: address.city,
                            state: address.state,
                            pin: address.pin,
                          );
                          if(showError==null){
                            address.buttonLoading();
                            address.update();
                            await UserDatabase().updateAddress(completeAddress: address.completeAddress);
                            address.buttonLoading();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(
                                  content: Text(showError),
                                  backgroundColor: Palette.primaryColor.withOpacity(0.4),
                                  duration: Duration(seconds: 5),
                                )
                            );
                          }
                          address.processRunning();
                        } : (){},
                        child: Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Palette.primaryColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: !address.loading ? Text(address.address!=null ? "Update Address" : "Add Address", style: TextStyle(fontWeight: FontWeight.bold),) :
                              SpinKitThreeBounce(
                              color: Palette.primaryColor,
                              size: 20,
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
