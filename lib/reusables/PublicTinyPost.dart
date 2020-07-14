import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

import 'MiniCategoryForPost.dart';

class PublicTinyPost extends StatefulWidget {
  final image;
  final username;
  final onTap;
  final category;
  PublicTinyPost({this.image, this.onTap, this.username, this.category});
  @override
  _PublicTinyPostState createState() => _PublicTinyPostState();
}

class _PublicTinyPostState extends State<PublicTinyPost> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.image);
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                this.widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${this.widget.username}',
                  style: kTextStyle,
                ),
              ),

//              Wrap(
//                direction: Axis.vertical,
//                children: this
//                    .widget
//                    .category
//                    .map(
//                      (item) => MiniCategoryForPost(
//                        name: item,
//                      ),
//                    )
//                    .toList()
//                    .cast<Widget>(),
//              ),
            ],
          ),
        ],
      ),
    );
  }
}
