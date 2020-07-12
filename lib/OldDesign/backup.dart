import 'package:flutter/material.dart';
import '../services/constants.dart';

class PostCard extends StatelessWidget {
  final time;
  final name;
  final content;
  final isImage;
  final image;
  final isPortrait;
  final caption;
  PostCard(
      {this.time,
      this.name,
      this.content,
      this.isImage,
      this.caption,
      this.image,
      this.isPortrait});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: kDarkBackground,
          elevation: 0,
          child: Column(
            children: <Widget>[
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(20),
                color: kDarkBackground,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              height: 50,
                              width: 50,
                              child: Image.asset('images/logomain.png')),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              name,
                              style: kTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '21st Aug 2020, 10:32 PM',
                        style: kTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
              isPortrait
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Padding(
                        padding: isPortrait
                            ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
                            : EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: isImage
                              ? Image.asset(image)
                              : Flexible(
                                  child: Container(
                                    child: Text(
                                      content,
                                      style: kTextStyle,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Padding(
                        padding: isPortrait
                            ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
                            : EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: isImage
                              ? Image.asset(image)
                              : Text(
                                  content,
                                  style: kTextStyle,
                                ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                color: Color(0xFF263859),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.thumb_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '370',
                            style: kTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.height / 18,
                                decoration: BoxDecoration(
                                  color: Color(0xFF263859),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                )),
                          ),
                          Text(
                            '38',
                            style: kTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        caption,
                        style: kTextStyle.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
