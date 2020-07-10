import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

class MiniCategory extends StatefulWidget {
  const MiniCategory({this.name, this.onPress});

  final name;
  final onPress;
  @override
  _MiniCategoryState createState() => _MiniCategoryState();
}

class _MiniCategoryState extends State<MiniCategory> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () {
            if (zSelected.length < 3) {
              if (zSelected.contains(this.widget.name)) {
                setState(() {
                  selected = false;
                  print(selected);
                  zSelected.remove(this.widget.name);
                  print(this.widget.name);
                });
              } else {
                setState(() {
                  selected = true;
                  print(selected);
                  zSelected.add(this.widget.name);
                  print(this.widget.name);
                });
              }
            } else {
              print('too much');
              setState(() {
                selected = false;
                print(selected);
                zSelected.remove(this.widget.name);
                print(this.widget.name);
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected ? Colors.grey : kBackground),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                this.widget.name,
                style: kTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
