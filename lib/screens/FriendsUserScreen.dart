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

class FriendUserScreen extends StatefulWidget {
  static const String id = 'FriendUserScreen';
  @override
  _FriendUserScreenState createState() => _FriendUserScreenState();
}

class _FriendUserScreenState extends State<FriendUserScreen> {
  List<Container> myList = [];
  IconData temp;
  Color tempBack;
  final _store = Firestore.instance;
  bool requested = false;
  bool show = false;
  bool done = false;
  List<Map<String, dynamic>> zFriendsProfile = [];

  // Creating Category List
  createList() {
    print('creating list');

    String tempCategory;

    for (var i = 0; i < zFriends[clickedIndex]['category'].length; i++) {
      tempCategory = zFriends[clickedIndex]['category'][i];
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

  // To Follow or UnFollow
  showAlertDialog(BuildContext context) {
    // set up the buttons
    print(zFriendsMail);
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      color: Colors.blueAccent,
      onPressed: () async {
        await _store
            .collection('Users')
            .document(zDocumentID)
            .collection('Friend Request')
            .add({
          'requestMail': zFriendsMail[clickedIndex],
        });

        // Remove my Friend
        await _store
            .collection('Users')
            .document(zDocumentID)
            .collection('Friends')
            .where('mail', isEqualTo: zFriendsMail[clickedIndex])
            .getDocuments()
            .then((value) {
          for (var i in value.documents) {
            i.reference.delete();
          }
        });

        // Remove his Friend
        await _store
            .collection('Users')
            .document(zFriendsDocID[clickedIndex])
            .collection('Friends')
            .where('mail', isEqualTo: zUserMail)
            .getDocuments()
            .then((value) {
          for (var i in value.documents) {
            i.reference.delete();
          }
        });
        Navigator.pop(context);
      },
    );
    Widget noButton = FlatButton(
      color: Colors.redAccent,
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: kBackground,
      titleTextStyle: kTextStyle.copyWith(fontSize: 18),
      contentTextStyle: kTextStyle,
      title: Text("AlertDialog"),
      content: Text(
          "Do you wanna stop following your friend ${zFriends[clickedIndex]['username']}"),
      actions: [
        yesButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future getFriendPost() async {
    await _store
        .collection('Post')
        .where('user', isEqualTo: zFriends[clickedIndex]['mail'])
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        zFriendsProfile.add(i.data);
        print(zFriendsProfile);
      }
      setState(() {
        done = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('User Profile Screen');
    getFriendPost();
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
                                  zFriends[clickedIndex]['username'],
                                  style: kTextStyle.copyWith(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${zFriends[clickedIndex]['district']}, ${zFriends[clickedIndex]['state']}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // Open Model
                          showAlertDialog(context);
                        },
                        child: Container(
                          width: sWidth / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.indigo, Colors.cyan])),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Friend',
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Chat Screen
                        },
                        child: Container(
                          width: sWidth / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [Colors.indigo, Colors.cyan])),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Talk',
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            done
                ? Expanded(
                    child: Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: zFriendsProfile.length,
                        itemBuilder: (BuildContext context, int index) =>
                            TinyPost(
                          image: zFriendsProfile[index]['url'],
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                      ),
                    ),
                  )
                : Text('loading'),
          ],
        ),
      ),
    );
  }
}
