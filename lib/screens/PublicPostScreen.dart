import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        children: <Widget>[
          PostCard(
            name: 'PAbleBoo21',
            image: 'images/trial4.jpg',
            isPortrait: false,
            isImage: true,
            caption:
                'PAbleBoo21. Yo i am going to join Offline TV. I am happy to say this. DO subscribe to the channel...',
          ),
          PostCard(
            name: 'PAbleBoo21',
            image: 'images/trial2.jpg',
            isPortrait: true,
            isImage: true,
            caption:
                'PAbleBoo21. Yo i am going to join Offline TV. I am happy to say this. DO subscribe to the channel...',
          ),
          PostCard(
            name: 'PAbleBoo21',
            image: 'images/trial3.jpg',
            isImage: true,
            isPortrait: true,
            caption:
                'PAbleBoo21. Yo i am going to join Offline TV. I am happy to say this. DO subscribe to the channel...',
          ),
        ],
      ),
    );
  }
}
