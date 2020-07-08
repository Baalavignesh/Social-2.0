import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusable.dart';
import 'package:newsocialmedia/services/constants.dart';

class FindFriendsTab extends StatefulWidget {
  @override
  _FindFriendsTabState createState() => _FindFriendsTabState();
}

class _FindFriendsTabState extends State<FindFriendsTab> {
  final _store = Firestore.instance;

  getPeopleNearMe() async {
    CollectionReference col = _store.collection('Users');

    Query sDistrict = col.where('district', isEqualTo: zDistrict);
    sDistrict.getDocuments().then((value) {
      print('********************* District People **************************');
      for (var i in value.documents) {
        print(i.data['username']);
        uNearMe.add(i.data);
      }

      Query sState = col.where('state', isEqualTo: zState);
      sState.getDocuments().then((value) {
        print('********************* State People **************************');
        for (var i in value.documents) {
          if (i.data['district'] != zDistrict) {
            print(i.data['username']);
            uNearMe.add(i.data);
          }
        }

        Query sCountry = col.where('country', isEqualTo: zCountry);
        sCountry.getDocuments().then((value) {
          print(
              '********************* Country People **************************');
          for (var i in value.documents) {
            if (i.data['state'] != zState) {
              print(i.data['username']);
              uNearMe.add(i.data);
            }
          }
        });
      });
    });
  }

  createNearMeList() {
    for (var i = 0; i < uNearMe.length; i++) {
      Container uList = friendsBox(
        FaIcon(FontAwesomeIcons.pumpMedical),
        uNearMe[i]['username'],
        uNearMe[i]['district'],
        uNearMe[i]['state'],
        'Games, Movies, Coding, Books, Just Chatting, Video Editing',
      );
      uNearMeList.add(uList);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeopleNearMe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('called');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
//    uNearMe = [];
//    uNearMeList = [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              print(uNearMe);
            },
            child: Text('Refresh'),
            color: Colors.cyan,
          ),
          Column(
            children: uNearMeList,
          ),
        ],
      ),
    );
  }
}
