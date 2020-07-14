import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusable.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusableStateful.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:newsocialmedia/tabs/FriendsBoxReusable2.dart';

class FriendRequestTab extends StatefulWidget {
  @override
  _FriendRequestTabState createState() => _FriendRequestTabState();
}

class _FriendRequestTabState extends State<FriendRequestTab> {
  final _store = Firestore.instance;
  List<String> requestReceived = [];
  String information = 'Loading...';
  bool created = false;

  Future getFriendRequest() async {
    setState(() {
      aFriendRequestDocID = [];
      requestReceived = [];
      aFriendRequest = [];
      aFriendRequestName = [];
      aFriendRequestList = [];
      created = false;
    });
    print('get friend request');
    await _store
        .collection('Users')
        .document(zDocumentID)
        .collection('Friend Request')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        print('request received ${i.data}');
        print(i.data['requestMail']);
        requestReceived.add(i.data['requestMail']);
      }
      print('request received has $requestReceived');
    });

    if (requestReceived.length == 0) {
      setState(() {
        information = 'No Friend Request';
      });
    } else {
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
            aFriendRequestMail.add(i.data['mail']);
          }
        });
      }
      print('after that');
      print('show only my friends $aFriendRequest');
      if (aFriendRequestName.length != 0) {
        print('inside');
        print(aFriendRequestName.length);
        setState(() {
          created = true;
          print('state is set $created');
        });
      }
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
    created = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return created
        ? Container(
            child: ListView.builder(
              itemCount: aFriendRequest.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) {
                // Turning the List to String to Display in Box

                print('$i length is ${aFriendRequest.length}');
                String cat;

                var concatenate = StringBuffer();
                aFriendRequest[i]['category'].forEach((item) {
                  concatenate.write(' $item,');
                });
                cat = concatenate.toString();
                cat = cat.substring(0, cat.length - 1);

                return FriendBoxStateful(
                  uFriend: aFriendRequest[i]['username'],
                  uCategory: cat,
                  uDistrict: aFriendRequest[i]['district'],
                  uState: aFriendRequest[i]['state'],
                  requestFriend: true,
                  uMail: aFriendRequest[i]['mail'],
                );
              },
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                information,
                style: kTextStyle.copyWith(fontSize: 20),
              ),
            ],
          );
  }
}
