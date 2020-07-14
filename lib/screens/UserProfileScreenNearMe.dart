import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/ProfileCategoryBox.dart';
import 'package:newsocialmedia/reusables/TinyPost.dart';
import 'package:newsocialmedia/services/constants.dart';

import 'package:newsocialmedia/tabs/PostTab.dart';
import 'package:newsocialmedia/tabs/TimelineTab.dart';

class UserProfileScreenNearMe extends StatefulWidget {
  static const String id = 'UserProfileScreenNearMe';
  @override
  _UserProfileScreenNearMeState createState() =>
      _UserProfileScreenNearMeState();
}

class _UserProfileScreenNearMeState extends State<UserProfileScreenNearMe> {
  List<Container> myList = [];
  IconData temp;
  Color tempBack;
  final _store = Firestore.instance;
  bool requested = false;
  bool show = false;
  bool aPrivate = true;
  List<Map<String, dynamic>> aNearMePost = [];
  String profilePic =
      'https://firebasestorage.googleapis.com/v0/b/social-2-e4146.appspot.com/o/defaultFinal.jpg?alt=media&token=74dd98bd-d217-47ba-9de5-e1b839589799';

  Future getUserData() async {
    String temp = uNearMe[clickedIndex]['url'];
    print(temp);
    try {
      if (temp.length == 0) {
        // do nothing
      } else {
        profilePic = temp;
      }
    } catch (e) {
      print(e);
    }

    String clickedDocID = uNearMeDocID[clickedIndex];
    print(clickedDocID);
    String docID;
    await _store
        .collection('Users')
        .document(clickedDocID)
        .collection('Friend Request')
        .where('mailRequest', isEqualTo: zUserMail)
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        print(i.documentID);
        print(i.data);
        docID = i.documentID;
      }
    });
    if (docID != null) {
      setState(() {
        print('Requested');
        show = true;
        requested = true;
      });
    } else {
      print('Follow');
      setState(() {
        requested = false;
        show = true;
      });
    }

    print(uNearMe[clickedIndex]['mail']);
    await _store
        .collection('Post')
        .where('user', isEqualTo: uNearMe[clickedIndex]['mail'])
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        print(i.data);
        aNearMePost.add(i.data);
      }
      setState(() {
        aPrivate = uNearMe[clickedIndex]['private'];
        print('value of private : $aPrivate');
      });
    });

    print('After dAta');
  }

  createList() {
    print('creating list');

    String tempCategory;

    for (var i = 0; i < uNearMe[clickedIndex]['category'].length; i++) {
      tempCategory = uNearMe[clickedIndex]['category'][i];
//      print(i);
//      print(tempCategory);
      if (tempCategory == 'Gaming') {
        temp = Icons.gamepad;
        tempBack = Colors.blueAccent;
      }
      if (tempCategory == 'Book') {
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
                            child: Image.network(
                              profilePic,
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
                                    uNearMe[clickedIndex]['username'],
                                    style: kTextStyle.copyWith(fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${uNearMe[clickedIndex]['district']}, ${uNearMe[clickedIndex]['state']}',
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
                      child: requested
                          ? GestureDetector(
                              onTap: () async {
                                // UnFollow Function
                                setState(() {
                                  requested = false;
                                });
                                String delDoc;
                                await _store
                                    .collection('Users')
                                    .document(uNearMeDocID[clickedIndex])
                                    .collection('Friend Request')
                                    .where('requestMail', isEqualTo: zUserMail)
                                    .getDocuments()
                                    .then((value) {
                                  for (var i in value.documents) {
                                    print(i.documentID);
                                    delDoc = i.documentID;
                                  }
                                });

                                await _store
                                    .collection('Users')
                                    .document(uNearMeDocID[clickedIndex])
                                    .collection('Friend Request')
                                    .document(delDoc)
                                    .delete();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.white)),
                                child: show
                                    ? Center(
                                        child: Text(
                                        'Requested',
                                        style: kTextStyle,
                                        textAlign: TextAlign.center,
                                      ))
                                    : SpinKitWave(
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                // Follow Function

                                setState(() {
                                  requested = true;
                                });

                                String tempDocID = uNearMeDocID[clickedIndex];
                                print(tempDocID);
                                await _store
                                    .collection('Users')
                                    .document(uNearMeDocID[clickedIndex])
                                    .collection('Friend Request')
                                    .add({'requestMail': zUserMail});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.white)),
                                child: show
                                    ? Center(
                                        child: Text(
                                          'Follow',
                                          style: kTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : SpinKitWave(
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                              ),
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
                          itemCount: aNearMePost.length,
                          itemBuilder: (BuildContext context, int index) =>
                              TinyPost(
                            image: aNearMePost[index]['url'],
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
