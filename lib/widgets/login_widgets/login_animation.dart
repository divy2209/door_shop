import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoginAnimatedText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: SizedBox(
        child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 60
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