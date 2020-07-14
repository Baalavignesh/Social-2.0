import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/screens/WelcomeScreen.dart';
import 'package:newsocialmedia/services/MailAuth.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:newsocialmedia/screens/CategoryScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "LoadingScreen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _store = Firestore.instance;
  bool firstTime = false;

  Future getUserData() async {
    setState(() {
      zCategory = [];
    });
    print('getUserData Function in Loading Screen');
    List<dynamic> myCategory = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _store
        .collection('Users')
        .where('mail', isEqualTo: zUserMail)
        .limit(1)
        .getDocuments()
        .then((value) {
      print(value.documents);
      DocumentSnapshot document = value.documents.first;
      final doc = document.data;
      print(doc);
      zUsername = doc['username'];
      myCategory = doc['category'];
      zURL = doc['url'];
      for (var i = 0; i < myCategory.length; i++) {
        print(i);
        zCategory.add(myCategory[i]);
      }

      zUserMail = doc['mail'];
      prefs.setString('username', zUsername);
      prefs.setStringList('category', zCategory);
      prefs.setString('documentid', document.documentID);
      prefs.setString('url', zURL);
      prefs.setBool('private', zPublic);
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
      }
      prefs.setStringList('friends', zFriendsMail);
    });
  }

  Future checkUser() async {
    setState(() {
      zFriendsMail = [];
    });
    print('Initial checking $zUserMail and $zUsername');
    await _store.collection('Users').getDocuments().then((value) {
      for (var i in value.documents) {
        print(i.data['mail']);
        if (i.data.containsValue(zUserMail)) {
          print('checking');
          setState(() {
            firstTime = false;
          });
          break;
        } else {
          print('Not there');
          setState(() {
            firstTime = true;
          });
        }
      }
    }).then((value) {
      if (firstTime == false) {
        print('User Already Exists');
//        Future.delayed(Duration(seconds: 3), () {
//        });
      } else {
        print('New User');
        Navigator.pushReplacementNamed(context, CategoryScreen.id);
      }
    });
    await getUserData();
    Navigator.pushReplacementNamed(context, MainRoutePage.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Loading Screen');
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Optimizing your Feed',
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
    );
  }
}
