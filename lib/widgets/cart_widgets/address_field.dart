import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressField extends StatelessWidget {
  final double h, w;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FilteringTextInputFormatter inputFormat;
  final int textLength;
  final String value;
  AddressField({this.h, this.w, this.hint, this.inputAction, this.inputType, this.inputFormat, this.textLength, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 6),
      child: Container(
        height: h,
        width: w,
        child: Center(
          child: TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              focusColor: Palette.primaryColor,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 16, color: Colors.black),
            ),
            cursorColor: Palette.primaryColor,
            style: TextStyle(
              fontSize: 16
            ),
            onChanged: (value){
              Provider.of<AddressData>(context, listen: false).input(hint, value);
            },
            keyboardType: inputType,
            textInputAction: inputAction,
            inputFormatters: [inputFormat ?? FilteringTextInputFormatter.singleLineFormatter, LengthLimitingTextInputFormatter(textLength ?? 500)],
          ),
        ),
      ),
    );
  }
}
