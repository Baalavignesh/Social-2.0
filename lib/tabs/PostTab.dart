import 'package:flutter/material.dart';
import 'package:newsocialmedia/screens/SinglePostScreen.dart';
import 'package:page_transition/page_transition.dart';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              TinyImageBox(
                onPress: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SinglePostScreen(
                          image: 'images/trial1.jpg',
                          isImage: false,
                        )),
                  );
                },
                image: 'images/trial1.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial3.jpg',
              ),
              TinyImageBox(
                image: 'images/trial4.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial4.jpg',
              ),
              TinyImageBox(
                image: 'images/trial1.jpg',
              ),
              TinyImageBox(
                image: 'images/trial3.jpg',
              ),
              TinyImageBox(
                image: 'images/trial3.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial1.jpg',
              ),
              TinyImageBox(
                image: 'images/trial4.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial1.jpg',
              ),
              TinyImageBox(
                image: 'images/trial4.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial3.jpg',
              ),
              TinyImageBox(
                image: 'images/trial1.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
              TinyImageBox(
                image: 'images/trial2.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TinyImageBox extends StatelessWidget {
  final image;
  final onPress;
  const TinyImageBox({this.image, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: MediaQuery.of(context).size.height / 8.5,
          width: MediaQuery.of(context).size.height / 8.5,
          child: FittedBox(
            child: Image.asset(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
