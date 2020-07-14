import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool noFriends = false;

  Future getFriendsPost() async {
    setState(() {
      noFriends = false;
    });
    print('Get Friends Post Function');
    print(Timestamp.now());
    print(DateTime.now().millisecondsSinceEpoch);
    print(zFriendsMail);
    print(zCategory);

    print('$zFriendsMail yea the valee');
    print(zFriendsMail.length);
    if (zFriendsMail.length == 0) {
      print('inside');
      setState(() {
        noFriends = true;
      });
    } else {
      for (var i in zFriendsMail) {
        print(i);

        await _store
            .collection('Post')
            .where('user'[0], isEqualTo: i)
            .getDocuments()
            .then((value) {
          for (var i in value.documents) {
            print(i.data);
          }
        });
        await _store
            .collection('Post')
            .where('user', isEqualTo: i)
            .where('post category', arrayContainsAny: zCategory)
            .getDocuments()
            .then((value) {
          for (var i in value.documents) {
            print(i.data);
            zFriendsPost.add(i.data);
          }

          setState(() {
            fetchingPost = true;
          });
        });
      }
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
        child: fetchingPost
            ? Column(
                children: <Widget>[
//          topContainerFriendsTab(),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: zFriendsPost.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return PostCard(
                              name: zFriendsPost[i]['username'],
                              isPortrait: zFriendsPost[i]['imagetype'],
                              isImage: zFriendsPost[i]['is photo'],
                              caption: zFriendsPost[i]['caption'],
                              image: zFriendsPost[i]['url'],
                              category: zFriendsPost[i]['post category'],
                            );
                          }),
                    ),
                  )
                ],
              )
            : noFriends
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'No Friends',
                        style: kTextStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Loading Friends Post',
                          style: kTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SpinKitWave(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ],
                  ));
  }
}
