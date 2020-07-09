import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/ProfileCategoryBox.dart';
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
  String requestDocID;
  String tempMail = aFriendRequest[clickedIndex]['mail'];

  Future getUserData() async {}

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
                                          aFriendRequest[clickedIndex]
                                              ['username'],
                                          style:
                                              kTextStyle.copyWith(fontSize: 22),
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
                                scrollDirection: Axis.horizontal,
                                children: myList),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: accepted
                                ? GestureDetector(
                                    onTap: () async {
                                      // Remove Friend Function
                                      setState(() {
                                        accepted = false;
                                      });

                                      // Adding back my Friend Request List
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friend Request')
                                          .add({
                                        'requestMail':
                                            aFriendRequest[clickedIndex]['mail']
                                      });

                                      // Remove my Friend
                                      //Get Document ID
                                      String myFriend;
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friends')
                                          .where('mail',
                                              isEqualTo:
                                                  aFriendRequest[clickedIndex]
                                                      ['mail'])
                                          .getDocuments()
                                          .then((value) {
                                        for (var i in value.documents) {
                                          myFriend = i.documentID;
                                        }
                                      });

                                      // Delete Document ID
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friends')
                                          .document(myFriend)
                                          .delete();

                                      // Remove his Friend
                                      String removeHisFriend;
                                      print('reqadad $requestDocID');
                                      await _store
                                          .collection('Users')
                                          .document(
                                              aFriendRequestDocID[clickedIndex])
                                          .collection('Friends')
                                          .where('mail', isEqualTo: zUserMail)
                                          .getDocuments()
                                          .then((value) {
                                        for (var i in value.documents) {
                                          print(i);
                                          setState(() {
                                            removeHisFriend = i.documentID;
                                          });
                                          print(removeHisFriend);
                                        }
                                      });

                                      await _store
                                          .collection('Users')
                                          .document(
                                              aFriendRequestDocID[clickedIndex])
                                          .collection('Friends')
                                          .document(removeHisFriend)
                                          .delete();
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Center(
                                            child: Text(
                                          'Friend',
                                          style: kTextStyle,
                                          textAlign: TextAlign.center,
                                        ))),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        accepted = true;
                                      });

                                      // Accept Function

                                      String tempDocID =
                                          aFriendRequestDocID[clickedIndex];
                                      print('tempMail : $tempMail');
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friend Request')
                                          .where('requestMail',
                                              isEqualTo: tempMail)
                                          .getDocuments()
                                          .then((value) {
                                        for (var i in value.documents) {
                                          print(
                                              'i data ${i.data} and i doc ${i.documentID}');
                                          setState(() {
                                            requestDocID = i.documentID;
                                          });
                                        }
                                      });

                                      // Getting Document ID of the Request Received

                                      // Deleting Friend Request From my Profile
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friend Request')
                                          .document(requestDocID)
                                          .delete();

                                      // Adding to My Friend List
                                      await _store
                                          .collection('Users')
                                          .document(zDocumentID)
                                          .collection('Friends')
                                          .add({'mail': tempMail});

                                      // Adding to his Friend List
                                      await _store
                                          .collection('Users')
                                          .document(tempDocID)
                                          .collection('Friends')
                                          .add({'mail': zUserMail});
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border: Border.all(
                                                color: Colors.white)),
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
