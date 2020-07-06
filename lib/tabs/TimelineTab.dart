import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/PostCard.dart';
import 'package:newsocialmedia/services/constants.dart';

class TimelineTab extends StatefulWidget {
  @override
  _TimelineTabState createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kBackground,
        child: Column(
          children: <Widget>[
            PostCard(
              time: '21st Aug 2020, 10:32 PM',
              name: 'Baalavignesh',
              content: 'Hi. I am looking for Warzone players',
              isImage: false,
              isPortrait: false,
              image: null,
              caption: 'PAbleBoo21',
            ),
            PostCard(
              time: '21st Aug 2020, 10:32 PM',
              name: 'Baalavignesh',
              content: 'Hi. I am looking for Warzone players',
              isImage: true,
              isPortrait: true,
              image: 'images/trial1.jpg',
              caption: 'PAbleBoo21',
            ),
            PostCard(
              time: '21st Aug 2020, 10:32 PM',
              name: 'Baalavignesh',
              content: 'Hi. I am looking for Warzone players',
              isImage: true,
              isPortrait: false,
              image: 'images/trial4.jpg',
              caption: 'PAbleBoo21',
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineBox extends StatelessWidget {
  final time;
  final name;
  final content;
  final isImage;
  final image;
  const TimelineBox(
      {this.time, this.name, this.content, this.isImage, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          name,
                          textAlign: TextAlign.start,
                          style: kTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          time,
                          style: kTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isImage
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: FittedBox(
                            child: Image.asset(image),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          content,
                          style: kTextStyle,
                        ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.thumb_up),
                        Icon(Icons.comment),
                      ],
                    ),
                  )
                ],
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
