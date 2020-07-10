import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsocialmedia/screens2/CaptionAndImageScreen.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'dart:async';
import 'dart:io';

class FriendsPostScreen extends StatefulWidget {
  static const String id = 'FriendsPostScreen';
  @override
  _FriendsPostScreenState createState() => _FriendsPostScreenState();
}

class _FriendsPostScreenState extends State<FriendsPostScreen> {
  final picker = ImagePicker();
  getImageCamera() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      Navigator.pop(context);
      Navigator.pushNamed(context, CaptionAndImageScreen.id);
    } catch (e) {
      print(e);
    }
  }

  getImageGallery() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      Navigator.pop(context);
      Navigator.pushNamed(context, CaptionAndImageScreen.id);
    } catch (e) {
      print(e);
    }
  }

  bottomModal() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Gallery'),
                    onTap: () async {
                      await getImageGallery();
                    }),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageCamera();
                  },
                ),
              ],
            ),
          );
        });
  }

  getFriendsPost() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Friends Post Screen');
    getFriendsPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Say Something to People',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onChanged: (value) {
                        zUserMail = value;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 10, 30),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.book,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              bottomModal();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 30),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 40, 30),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 25,
                          child: Icon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
