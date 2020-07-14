import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newsocialmedia/reusables/PostCard.dart';
import 'package:newsocialmedia/reusables/PublicTinyPost.dart';
import 'package:newsocialmedia/reusables/TinyPost.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicPostScreen extends StatefulWidget {
  static const String id = 'PublicPostScreen';
  @override
  _PublicPostScreenState createState() => _PublicPostScreenState();
}

class _PublicPostScreenState extends State<PublicPostScreen> {
  bool trial = true;
  final _store = Firestore.instance;
  List<Map<String, dynamic>> zPublicPost = [];
  bool done = false;

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    zUsername = (prefs.getString('username'));
    zUserMail = (prefs.getString('mail'));
    zCategory = (prefs.getStringList('category'));
    zDocumentID = (prefs.getString('documentid'));
    zLatitude = (prefs.getDouble('latitude'));
    zLongitude = (prefs.getDouble('longitude'));
    zCountry = (prefs.getString('country'));
    zDistrict = (prefs.getString('district'));
    zState = (prefs.getString('state'));
    zFriendsMail = (prefs.getStringList('friends'));
    zPublic = (prefs.getBool('private'));
    zURL = (prefs.getString('url'));
    print(zURL.length);
    print('dumb $zFriendsMail');
    setState(() {
      zFriendsMail = [];
    });
    await _store
        .collection('Users')
        .document(zDocumentID)
        .collection('Friends')
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
        zFriends.add(i.data);
        String frn = i.data['mail'];
        print(frn);
        zFriendsMail.add(frn);
//        zFriendsMail.add(frn);
      }
    });

    prefs.setStringList('friends', zFriendsMail);

    print(zDocumentID);
    print(zCategory);
    sHeight = MediaQuery.of(context).size.height;
    sWidth = MediaQuery.of(context).size.width;
  }

  Future getPublicPost() async {
    print('Getting Prople Near Me Function');
    print('$zDistrict - $zState - $zCountry');
    print(zCategory);
    Query col = _store
        .collection('Users')
        .where('category', arrayContainsAny: zCategory);

    await col.getDocuments().then((value) {
      for (var i in value.documents) {
        print(i.data);
      }
    });
    Query sDistrict = col
        .where('district', isEqualTo: zDistrict)
        .where('private', isEqualTo: false);
    await sDistrict.getDocuments().then((value) {
      print('********************* District People **************************');
      for (var i in value.documents) {
        if (i.data['username'] != zUsername) {
          print(i.data['username']);
          uNearMe.add(i.data);
          uNearMeDocID.add(i.documentID);
          uNearMeName.add(i.data['username']);
        }
      }
    });

    // State Data

    Query sState = col
        .where('state', isEqualTo: zState)
        .where('private', isEqualTo: false);
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
    Query sCountry = col
        .where('country', isEqualTo: zCountry)
        .where('private', isEqualTo: false);
    await sCountry.getDocuments().then((value) {
      print('********************* Country People ******************');
      for (var i in value.documents) {
        print(i.data);
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

    zPublicPostMail = [];
    for (var i = 0; i < uNearMe.length; i++) {
      print(i);
      String nearMeMail = uNearMe[i]['mail'];
      if (zFriendsMail.contains(nearMeMail)) {
        // He is my Friend
        print('Friend $nearMeMail');
      } else {
        zPublicPostMail.add(nearMeMail);
      }
    }

    print(zPublicPostMail);
    for (var i = 0; i < zPublicPostMail.length; i++) {
      await _store
          .collection('Post')
          .where('user', isEqualTo: zPublicPostMail[i])
          .getDocuments()
          .then((value) {
        for (var i in value.documents) {
          zPublicPost.add(i.data);
        }
      });
    }

    setState(() {
      done = true;
      print(zPublicPost);
    });

    print('after this');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    uNearMe = [];
    uNearMeList = [];
    uNearMeName = [];
    uNearMeDocID = [];
    zFriends = [];
    zFriendsMail = [];
    zPublicPost = [];
    getPublicPost();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: SafeArea(
        child: done
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: zPublicPost.length,
                        itemBuilder: (BuildContext context, int index) =>
                            PublicTinyPost(
                          image: zPublicPost[index]['url'],
                          username: zPublicPost[index]['username'],
                          category: zPublicPost[index]['post category'],
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                      ),
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Getting Public Post Near You',
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
              ),
      ),
    );
  }
}
