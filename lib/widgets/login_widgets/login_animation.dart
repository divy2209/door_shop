import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoginAnimatedText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 35),
      child: SizedBox(
        child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width*0.15
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                'Door Shop',
                cursor: '|',
                textAlign: TextAlign.start,
                speed: Duration(milliseconds: 180),
              ),
            ],
          ),
        ),
      ),
    );
  }
}