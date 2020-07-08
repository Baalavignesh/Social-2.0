import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

class BottomButton extends StatelessWidget {
  final onPress;
  final buttonText;
  final color;

  BottomButton({this.onPress, this.color, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFA52647)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            child: Text(
              buttonText,
              style: kTextStyle.copyWith(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
