import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/MiniCategoryForPost.dart';
import '../services/constants.dart';
import 'MiniCategory.dart';

class PostCard extends StatelessWidget {
  final time;
  final name;
  final isImage;
  final image;
  final isPortrait;
  final caption;
  final category;
  PostCard(
      {this.time,
      this.name,
      this.isImage,
      this.caption,
      this.image,
      this.isPortrait,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(20),
              color: kDarkBackground,
              elevation: 3,
              shadowColor: kBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
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
                          ' ',
                          style: kTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  isPortrait
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                fit: BoxFit.fitWidth,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                width: MediaQuery.of(context).size.width,
//                            height: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircleAvatar(
                                  child: FaIcon(
                                    FontAwesomeIcons.thumbsUp,
                                    color: Colors.black,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  child: FaIcon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Wrap(
                                children: category
                                    .map(
                                      (item) => MiniCategoryForPost(
                                        name: item,
                                      ),
                                    )
                                    .toList()
                                    .cast<Widget>(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: Text(
                            '$name $caption',
                            textAlign: TextAlign.left,
                            style: kTextStyle.copyWith(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
