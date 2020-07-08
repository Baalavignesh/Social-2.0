import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/PostCard.dart';
import 'package:newsocialmedia/services/constants.dart';

class SinglePostScreen extends StatefulWidget {
  final time;
  final name;
  final content;
  final isImage;
  final image;
  SinglePostScreen(
      {this.time, this.name, this.content, this.isImage, this.image});
  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBackground,
        title: Text(
          'Post',
          style: kTextStyle,
        ),
      ),
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PostCard(
              name: 'PAbleBoo21',
              image: 'images/trial1.jpg',
              isPortrait: true,
              isImage: true,
              caption: ' ',
            ),
          ],
        ),
      ),
    );
  }
}
