import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/PostCard.dart';

class PublicPostScreen extends StatefulWidget {
  static const String id = 'PublicPostScreen';
  @override
  _PublicPostScreenState createState() => _PublicPostScreenState();
}

class _PublicPostScreenState extends State<PublicPostScreen> {
  bool trial = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[Text(' ')],
      ),
    );
  }
}
