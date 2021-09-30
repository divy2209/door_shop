import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Button extends StatelessWidget {
  final String text;
  final Function click;
  final bool loading;

  Button({
    @required this.text,
    @required this.click,
    this.loading
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: Palette.buttonBoxDecoration,
      child: Theme(
        data: ThemeData(
            splashColor: Palette.primaryColor
        ),
        child: TextButton(
          onPressed: click,
          child: Visibility(
            visible: loading == null ? false : loading,
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 30,
            ),
            replacement: Text(
              text,
              style: Palette.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}