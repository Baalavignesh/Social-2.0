import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/reusables/FriendsBoxReusable.dart';
import 'package:newsocialmedia/services/constants.dart';

class FindFriendsTab extends StatefulWidget {
  @override
  _FindFriendsTabState createState() => _FindFriendsTabState();
}

class _FindFriendsTabState extends State<FindFriendsTab> {
  final _store = Firestore.instance;
  bool listCreated = false;
  List<String> friendsRequestDocID = [];
  List<String> friendsRequestName = [];
  bool nearTab = true;

  Future getPeopleNearMe() async {
    print('$zDistrict - $zState - $zCountry');
    CollectionReference col = _store.collection('Users');

    Query sDistrict = col.where('district', isEqualTo: zDistrict);
    await sDistrict.getDocuments().then((value) {
      print('********************* District People **************************');
      for (var i in value.documents) {
        print(i.data['username']);
        if (i.data['username'] != zUsername) {
          uNearMe.add(i.data);
          uNearMeDocID.add(i.documentID);
          uNearMeName.add(i.data['username']);
        }
      }
    });

    // State Data

    Query sState = col.where('state', isEqualTo: zState);
    await sState.getDocuments().then((value) {
      print('********************* State People **************************');
      for (var i in value.documents) {
        if (i.data['district'] != zDistrict) {
          print(i.data['username']);
          uNearMe.add(i.data);
          uNearMeDocID.add(i.documentID);
          uNearMeName.add(i.data['username']);
        }
      }
    });

    // Country Data
    Query sCountry = col.where('country', isEqualTo: zCountry);
    sCountry.getDocuments().then((value) {
      print('********************* Country People ******************');
      for (var i in value.documents) {
        if (i.data['state'] != zState) {
          print(i.data['username']);
          uNearMe.add(i.data);
          uNearMeDocID.add(i.documentID);
          uNearMeName.add(i.data['username']);
        }
      }
    });

    await _store
        .collection('Users')
        .document(zDocumentID)
        .collection('Friends')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        zFriends.add(i.data);
        zFriendsMail.add(i.data['mail']);
      }
    });
    print(zFriends);
    print('after this');
    createNearMeList();
  }

  createNearMeList() {
    print('Create Near Me List');
//    for (var k = 0; k < uNearMeDocID.length; k++) {
//      for (var m = 0; m < friendsRequestDocID.length; m++) {
//        if (uNearMeDocID[k] == (friendsRequestDocID[m])) {
//          print('Friend');
//          print(uNearMeName[k]);
//          friendsRequestName.add(uNearMeName[k]);
////          uNearMeName.removeAt(k);
////          uNearMe.removeAt(k);
//          break;
//        } else {
//          print('New People');
//        }
//      }
//    }

    for (var i = 0; i < uNearMe.length; i++) {
      bool requestedValue = false;

//      print(zFriends);
      // Check if that person is my Friend

      List uTemp = uNearMe[i]['category'];
      if (zCategory.any((element) => uTemp.contains(element))) {
        List temp = uNearMe[i]['category'];
        var concatenate = StringBuffer();
        temp.forEach((item) {
          concatenate.write(' $item,');
        });
        String cat = concatenate.toString();
        cat = cat.substring(0, cat.length - 1);

        String nearMeMail = uNearMe[i]['mail'];
        print(nearMeMail);
//        print(zFriends);
        print(zFriendsMail);
        if (zFriendsMail.contains(nearMeMail)) {
          print('He is my Friend');
//          uNearMe.removeAt(i);
        } else {
          //Creating Box

          Container uList = friendsBox(
            FaIcon(FontAwesomeIcons.pumpMedical),
            uNearMe[i]['username'],
            uNearMe[i]['district'],
            uNearMe[i]['state'],
            cat,
            context,
            nearTab,
          );
          uNearMeList.add(uList);
        }
      }

      print('*************************************************************');
    }
    setState(() {
      listCreated = true;
    });
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
    uNearMe = [];
    uNearMeList = [];
    uNearMeName = [];
    uNearMeDocID = [];
    zFriends = [];
    zFriendsMail = [];
    friendsRequestDocID = [];
  }

  @override
  Widget build(BuildContext context) {
    return listCreated
        ? SingleChildScrollView(
            child: Column(
              children: uNearMeList,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Getting People Near You',
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
          );
  }
}
