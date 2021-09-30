import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/widgets/cart_widgets/address_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<AddressData>(context, listen: false);
    return Form(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.location_on),
            Column(
              children: [
                AddressField(
                  h: 30,
                  w: 306,
                  value: address.address,
                  hint: AddressFieldHint.address,
                  inputType: TextInputType.streetAddress,
                  inputAction: TextInputAction.next,
                ),
                AddressField(
                    h: 30,
                    w: 306,
                    value: address.city,
                    hint: AddressFieldHint.city,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next
                ),
                Row(
                  children: [
                    AddressField(
                        h: 30,
                        w: 150,
                        value: address.state,
                        hint: AddressFieldHint.state,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next
                    ),
                    AddressField(
                      h: 30,
                      w: 150,
                      value: address.pin!=null ? address.pin.toString() : null,
                      hint: AddressFieldHint.pin,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      inputFormat: FilteringTextInputFormatter.digitsOnly,
                      textLength: 6,
                    ),
                  ],
                )
              ],
            ),
          ],
        )
    );
  }
}
