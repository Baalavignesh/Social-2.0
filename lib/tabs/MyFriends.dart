import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusable.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusableStateful.dart';
import 'package:newsocialmedia/services/constants.dart';

class MyFriendsTab extends StatefulWidget {
  @override
  _MyFriendsTabState createState() => _MyFriendsTabState();
}

class _MyFriendsTabState extends State<MyFriendsTab> {
  final _store = Firestore.instance;
  bool gotFriends = false;
  String information = 'Loading...';

  Future getFriends() async {
    print('getFriends Function');
//    print('doc id$zDocumentID');

    setState(() {
      zFriendsMail = [];
      zFriends = [];
      gotFriends = false;
    });

    await _store
        .collection('Users')
        .document(zDocumentID)
        .collection('Friends')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
//        print(i.data);
        zFriendsMail.add(i.data['mail']);
      }
    });

    print('Friends Mail $zFriendsMail');
    if (zFriendsMail.length == 0) {
      setState(() {
        information = 'No Friends';
      });
    } else {
      for (var i in zFriendsMail) {
        await _store
            .collection('Users')
            .where('mail', isEqualTo: i)
            .getDocuments()
            .then((value) {
          for (var i in value.documents) {
//          print(i.data);
            setState(() {
              zFriends.add(i.data);
              zFriendsDocID.add(i.documentID);
            });
          }
          print('$zFriends and ${zFriends.length}');
        });
        if (zFriends.length == 0 || zFriends == null) {
          print('still adding');
        } else {
          setState(() {
            gotFriends = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('My Friends');
    zFriends = [];
    getFriends();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
//    print('done');
    zFriends = [];
    gotFriends = false;
  }

  @override
  Widget build(BuildContext context) {
    return gotFriends
        ? Container(
            child: ListView.builder(
              itemCount: zFriends.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) {
                // Turning the List to String to Display in Box
//                print(i);
//                print(zFriends.length);
//                print('0 is ${zFriends[0]}');

//                print(zFriends[i]['category']);
                String cat;

                var concatenate = StringBuffer();
                zFriends[i]['category'].forEach((item) {
                  concatenate.write(' $item,');
                });
                cat = concatenate.toString();
                cat = cat.substring(0, cat.length - 1);

                return FriendBoxStateful(
                  uFriend: zFriends[i]['username'],
                  uCategory: cat,
                  uDistrict: zFriends[i]['district'],
                  uState: zFriends[i]['state'],
                  requestFriend: false,
                  uMail: zFriends[i]['mail'],
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
