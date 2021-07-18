import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isObscure;
  final IconData icon;
  final String hintText;
  final FilteringTextInputFormatter inputFormat;

  const InputField({
    Key key,
    @required this.isObscure,
    @required this.inputAction,
    this.inputType,
    @required this.controller,
    @required this.icon,
    @required this.hintText,
    this.inputFormat
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
            style: Palette.inputTextStyle,
            obscureText: isObscure,
            keyboardType: inputType,
            textInputAction: inputAction,
            inputFormatters: [inputFormat ?? FilteringTextInputFormatter.singleLineFormatter],
          )
        ),
      ),
    );
  }
}