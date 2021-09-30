import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/login_data.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isObscure;
  final IconData icon;
  final String hintText;
  final FilteringTextInputFormatter inputFormat;
  final String form;

  const InputField({
    Key key,
    this.isObscure,
    @required this.inputAction,
    this.inputType,
    @required this.controller,
    @required this.icon,
    @required this.hintText,
    this.inputFormat,
    @required this.form
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: Palette.textBoxDeco,
        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              hintText: hintText,
              hintStyle: Palette.inputTextStyle
            ),
            onChanged: (value){
              if(form == FormIdentifier.login){
                Provider.of<LoginData>(context, listen: false).login(value, hintText);
              } else if(form == FormIdentifier.register){
                Provider.of<RegisterData>(context, listen: false).register(value, hintText);
              }
            },
            style: Palette.inputTextStyle,
            obscureText: isObscure!=null ? isObscure : false,
            keyboardType: inputType,
            textInputAction: inputAction,
            inputFormatters: [inputFormat ?? FilteringTextInputFormatter.singleLineFormatter],
          )
        ),
      ),
    );
  }
}