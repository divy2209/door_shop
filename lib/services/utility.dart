import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

mixin Palette{
  static Color primaryColor = Vx.hexToColor("#2e8b57");
  static BoxDecoration textBoxDeco = BoxDecoration(
    color: Colors.grey[500].withOpacity(0.4),
    borderRadius: BorderRadius.circular(16)
  );
  static TextStyle inputTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    height: 1.5
  );

  static BoxDecoration buttonBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: primaryColor
  );
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    height: 1.5,
    fontWeight: FontWeight.bold
  );
}

mixin TextFieldInputDecoration{
  static InputDecoration phoneField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.phone,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Phone Number',
    hintStyle: Palette.inputTextStyle
  );
  static InputDecoration passwordField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.lock,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Password',
    hintStyle: Palette.inputTextStyle
  );
  static InputDecoration confirmPasswordField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.lock,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Confirm Password',
    hintStyle: Palette.inputTextStyle
  );
  static InputDecoration nameField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.user,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Full Name',
    hintStyle: Palette.inputTextStyle
  );
  static InputDecoration emailField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.envelope,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Email',
    hintStyle: Palette.inputTextStyle
  );
}