import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsocialmedia/reusables/PostCard.dart';
import 'file:///D:/4.%20Projects/Flutter_App/new_social_media/lib/screens/CaptionAndImageScreen.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'dart:async';
import 'dart:io';

class FriendsPostScreen extends StatefulWidget {
  static const String id = 'FriendsPostScreen';
  @override
  _FriendsPostScreenState createState() => _FriendsPostScreenState();
}

class _FriendsPostScreenState extends State<FriendsPostScreen>
    with SingleTickerProviderStateMixin {
  bool fetchingPost = false;
  final _store = Firestore.instance;
  ScrollController scrollController;

  Future getFriendsPost() async {
    print('Get Friends Post Function');
    print(Timestamp.now());
    print(DateTime.now().millisecondsSinceEpoch);
    print(zFriendsMail);
    print(zCategory);
    for (var i in zFriendsMail) {
      print(i);
      await _store
          .collection('Post')
          .where('user', isEqualTo: i)
          .where('post category', arrayContainsAny: zCategory)
          .getDocuments()
          .then((value) {
        for (var i in value.documents) {
//          print(i.data);
          zFriendsPost.add(i.data);
        }

        setState(() {
          fetchingPost = true;
        });
      });
    }
  }

//      .orderBy('timestamp', descending: true)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
//        print('1');
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    print('Friends Post Screen');
    getFriendsPost();
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
//      print(dialVisible);
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Friends Post Screen Deactivated');
    zFriendsPost = [];
    fetchingPost = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
//          topContainerFriendsTab(),
          fetchingPost
              ? Container(
                  child: Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: zFriendsPost.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          return PostCard(
                            name: zFriendsPost[i]['user'],
                            isPortrait: zFriendsPost[i]['imagetype'],
                            isImage: zFriendsPost[i]['is photo'],
                            caption: zFriendsPost[i]['caption'],
                            image: zFriendsPost[i]['url'],
                            category: zFriendsPost[i]['post category'],
                          );
                        }),
                  ),
                )
              : Text('Getting Post'),
        ],
      ),
    );
  }
}
