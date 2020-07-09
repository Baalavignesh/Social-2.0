import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusable.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:newsocialmedia/tabs/FriendsBoxReusable2.dart';

class FriendRequestTab extends StatefulWidget {
  @override
  _FriendRequestTabState createState() => _FriendRequestTabState();
}

class _FriendRequestTabState extends State<FriendRequestTab> {
  final _store = Firestore.instance;
  List<String> requestReceived = [];

  bool created = false;

  Future getFriendRequest() async {
    setState(() {
      aFriendRequestDocID = [];
      aFriendRequest = [];
      aFriendRequestName = [];
      aFriendRequestList = [];
    });
    print('get friend request');
    await _store
        .collection('Users')
        .document(zDocumentID)
        .collection('Friend Request')
        .getDocuments()
        .then((value) {
      for (var i = 0; i < value.documents.length; i++) {
        print('request received $i');
        print(value.documents[i].data['requestMail']);
        requestReceived.add(value.documents[i].data['requestMail']);
      }
    });
    for (var i = 0; i < requestReceived.length; i++) {
      print(i);
      await _store
          .collection('Users')
          .where('mail', isEqualTo: requestReceived[i])
          .getDocuments()
          .then((value) {
        for (var i in value.documents) {
          aFriendRequest.add(i.data);
          print(i.data['username']);
          aFriendRequestName.add(i.data['username']);
          aFriendRequestDocID.add(i.documentID);
        }
      });
    }
    print('after that');
    print(aFriendRequest);
    if (aFriendRequestName.length != 0) {
      print('inside');
      print(aFriendRequestName.length);
      createFriendRequest();
    }
  }

  createFriendRequest() {
    print('create list');
    for (var i = 0; i < aFriendRequest.length; i++) {
      List temp = aFriendRequest[i]['category'];

      // Turning the List to String to Display in Box
      var concatenate = StringBuffer();
      temp.forEach((item) {
        concatenate.write(' $item,');
      });
      String cat = concatenate.toString();
      cat = cat.substring(0, cat.length - 1);

      bool nearTab = false;
      Container uList = friendsBox(
          FaIcon(FontAwesomeIcons.smile),
          aFriendRequest[i]['username'],
          aFriendRequest[i]['district'],
          aFriendRequest[i]['state'],
          cat,
          context,
          nearTab);
      aFriendRequestList.add(uList);
    }
    print(aFriendRequestName);
    print(aFriendRequestDocID);
    if (aFriendRequestName == []) {
      print('nothing');
    }
    if (aFriendRequestName != []) {
      setState(() {
        created = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriendRequest();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print('Friend Request Screen Deactivate Called');
    super.deactivate();
    aFriendRequestDocID = [];
    aFriendRequest = [];
    aFriendRequestName = [];
    aFriendRequestList = [];
  }

  @override
  Widget build(BuildContext context) {
    return created
        ? SingleChildScrollView(
            child: Column(
              children: aFriendRequestList,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No Friend Request',
                style: kTextStyle.copyWith(fontSize: 20),
              ),
            ],
          );
  }
}
