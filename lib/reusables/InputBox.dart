import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final hint;
  final icon;
  InputTextField({this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 20,
          )),
    );
  }
}
