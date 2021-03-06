
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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

mixin Status{
  static final List<String> status = ['Order Placed', 'Processing', 'In Transit', 'Out for Delivery', 'Delivered'];
  static final List<Color> statusColor = [Colors.deepOrangeAccent.shade100, Colors.deepOrangeAccent.shade200, Colors.deepOrangeAccent.shade200, Colors.green.shade300, Colors.green];
}