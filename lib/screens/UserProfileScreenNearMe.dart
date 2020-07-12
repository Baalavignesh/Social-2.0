import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/ProfileCategoryBox.dart';
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

  Future getUserData() async {
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
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
//                  topContent(),
                  <Widget>[
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
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
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
                                          style:
                                              kTextStyle.copyWith(fontSize: 22),
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
                                scrollDirection: Axis.horizontal,
                                children: myList),
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
                                          .where('mailRequest',
                                              isEqualTo: zUserMail)
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
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border:
                                              Border.all(color: Colors.white)),
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

                                      String tempDocID =
                                          uNearMeDocID[clickedIndex];
                                      print(tempDocID);
                                      await _store
                                          .collection('Users')
                                          .document(uNearMeDocID[clickedIndex])
                                          .collection('Friend Request')
                                          .add({'mailRequest': zUserMail});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border:
                                              Border.all(color: Colors.white)),
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
                  ],
                ),
              ),
            ];
          },
          body: Container(
            child: Column(
              children: <Widget>[
                TabBar(
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.photo),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Post',
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timeline),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Timeline',
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      PostTab(),
                      TimelineTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
