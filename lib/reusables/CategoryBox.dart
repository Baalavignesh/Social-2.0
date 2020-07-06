import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

class CategoryBox extends StatelessWidget {
  final icon;
  final color;
  final text;
  final onPress;
  final selected;

  CategoryBox({this.icon, this.color, this.text, this.onPress, this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: selected ? Colors.blueGrey : Color(0xFF3B3E68),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(40),
                  elevation: 10,
                  child: Container(
                    child: Icon(
                      icon,
                      size: 35,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: kTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
