import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

class MiniCategoryForPost extends StatefulWidget {
  const MiniCategoryForPost({this.name});

  final name;
  @override
  _MiniCategoryForPostState createState() => _MiniCategoryForPostState();
}

class _MiniCategoryForPostState extends State<MiniCategoryForPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kBackground),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              this.widget.name,
              style: kTextStyle,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
