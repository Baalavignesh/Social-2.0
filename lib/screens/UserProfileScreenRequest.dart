import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/ProfileCategoryBox.dart';
import 'package:newsocialmedia/reusables/TinyPost.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/services/constants.dart';

import 'package:newsocialmedia/tabs/PostTab.dart';
import 'package:newsocialmedia/tabs/TimelineTab.dart';

class UserProfileScreenRequest extends StatefulWidget {
  static const String id = 'UserProfileScreenRequest';
  @override
  _UserProfileScreenRequestState createState() =>
      _UserProfileScreenRequestState();
}

class _UserProfileScreenRequestState extends State<UserProfileScreenRequest> {
  List<Container> myList = [];
  IconData temp;
  Color tempBack;
  final _store = Firestore.instance;
  bool accepted = false;
  bool show = false;
  String tempMail = aFriendRequest[clickedIndex]['mail'];
  bool aPrivate = true;
  List<Map<String, dynamic>> aFriendPost = [];

  Future getUserData() async {
    await _store
        .collection('Post')
        .where('user', isEqualTo: aFriendRequest[clickedIndex]['mail'])
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        print(i.data);
        aFriendPost.add(i.data);
      }
      setState(() {
        aPrivate = aFriendRequest[clickedIndex]['private'];
      });
    });
  }

  createList() {
    print('creating list');

    String tempCategory;

    for (var i = 0; i < aFriendRequest[clickedIndex]['category'].length; i++) {
      tempCategory = aFriendRequest[clickedIndex]['category'][i];

      if (tempCategory == 'Gaming') {
        temp = Icons.gamepad;
        tempBack = Colors.blueAccent;
      }
      if (tempCategory == 'Books') {
        temp = Icons.book;
        tempBack = Colors.purpleAccent;
      }
      if (tempCategory == 'Movies') {
        temp = Icons.movie;
        tempBack = Colors.green;
      }
      if (tempCategory == 'Coding') {
        temp = Icons.code;
        tempBack = Colors.orangeAccent;
      }
      if (tempCategory == 'Music') {
        temp = Icons.music_note;
        tempBack = Colors.pinkAccent;
      }
      if (tempCategory == 'Just Chatting') {
        temp = Icons.phone_in_talk;
        tempBack = Colors.redAccent;
      }
      if (tempCategory == 'Art') {
        temp = Icons.brush;
        tempBack = Colors.redAccent;
      }
      if (tempCategory == 'Editing') {
        temp = Icons.camera;
        tempBack = Colors.blueAccent;
      }
      if (tempCategory == 'Jobs') {
        temp = Icons.attach_file;
        tempBack = Colors.purpleAccent;
      }
      if (tempCategory == 'Sports') {
        temp = Icons.wb_sunny;
        tempBack = Colors.orangeAccent;
      }
      if (tempCategory == 'Fashion') {
        temp = Icons.perm_contact_calendar;
        tempBack = Colors.green;
      }
      try {
        Container tempContainer = profileCategory(temp, tempCategory, tempBack);
        myList.add(tempContainer);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('User Profile Screen');
    getUserData();
    createList();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBackground,
        appBar: AppBar(
          backgroundColor: kDarkBackground,
          title: Text(
            'Profile',
            style: kTextStyle,
          ),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: kDarkBackground,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'images/profilePic.jpg',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    aFriendRequest[clickedIndex]['username'],
                                    style: kTextStyle.copyWith(fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${aFriendRequest[clickedIndex]['district']}, ${aFriendRequest[clickedIndex]['state']}',
                                    style: kTextStyle.copyWith(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListView(
                          scrollDirection: Axis.horizontal, children: myList),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: accepted
                          ? GestureDetector(
                              onTap: () async {
                                // Remove Friend Function
                                setState(() {
                                  accepted = false;
                                  Navigator.pushReplacementNamed(
                                      context, MainRoutePage.id);
                                });

                                // Adding back my Friend Request List
                                await _store
                                    .collection('Users')
                                    .document(zDocumentID)
                                    .collection('Friend Request')
                                    .add({
                                  'requestMail': aFriendRequest[clickedIndex]
                                      ['mail']
                                });

                                // Remove my Friend
                                await _store
                                    .collection('Users')
                                    .document(zDocumentID)
                                    .collection('Friends')
                                    .where('mail',
                                        isEqualTo: aFriendRequest[clickedIndex]
                                            ['mail'])
                                    .getDocuments()
                                    .then((value) {
                                  for (var i in value.documents) {
                                    i.reference.delete();
                                  }
                                });

                                // Remove his Friend
                                await _store
                                    .collection('Users')
                                    .document(aFriendRequestDocID[clickedIndex])
                                    .collection('Friends')
                                    .where('mail', isEqualTo: zUserMail)
                                    .getDocuments()
                                    .then((value) {
                                  for (var i in value.documents) {
                                    i.reference.delete();
                                  }
                                });
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                      child: Text(
                                    'Friend',
                                    style: kTextStyle,
                                    textAlign: TextAlign.center,
                                  ))),
                            )
                          : GestureDetector(
                              onTap: () async {
                                // Accept Function
                                setState(() {
                                  accepted = true;
                                  Navigator.pushReplacementNamed(
                                      context, MainRoutePage.id);
                                });

                                // Deleting Friend Request From my Profile
                                await _store
                                    .collection('Users')
                                    .document(zDocumentID)
                                    .collection('Friend Request')
                                    .where('requestMail', isEqualTo: tempMail)
                                    .getDocuments()
                                    .then((value) {
                                  for (var i in value.documents) {
                                    i.reference.delete();
                                  }
                                });

                                // Adding to My Friend List
                                await _store
                                    .collection('Users')
                                    .document(zDocumentID)
                                    .collection('Friends')
                                    .add({'mail': tempMail});

                                // Adding to his Friend List
                                await _store
                                    .collection('Users')
                                    .document(aFriendRequestDocID[clickedIndex])
                                    .collection('Friends')
                                    .add({'mail': zUserMail});
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                    child: Text(
                                      'Accept',
                                      style: kTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
              ),
              aPrivate
                  ? Text('The Account is Private')
                  : Expanded(
                      child: Container(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          itemCount: aFriendPost.length,
                          itemBuilder: (BuildContext context, int index) =>
                              TinyPost(
                            image: aFriendPost[index]['url'],
                          ),
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.fit(2),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
