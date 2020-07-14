import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsocialmedia/reusables/ProfileCategoryBox.dart';
import 'package:newsocialmedia/reusables/TinyPost.dart';
import 'package:newsocialmedia/screens/FriendsListScreen.dart';
import 'package:newsocialmedia/services/MailAuth.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'CategoryScreen.dart';
import 'WelcomeScreen.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = 'UserProfileScreen';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Container> myList = [];
  IconData temp;
  Color tempBack;
  Timestamp time;
  final _storage = FirebaseStorage.instance;
  final _store = Firestore.instance;
  bool done = false;
  bool isSwitched = false;
  bool uploaded = false;
  String imageURL;
  String profilePic =
      'https://firebasestorage.googleapis.com/v0/b/social-2-e4146.appspot.com/o/defaultFinal.jpg?alt=media&token=74dd98bd-d217-47ba-9de5-e1b839589799';
  final picker = ImagePicker();

  Future getUserData() async {
    setState(() {
      zPublic = false;
    });
    print('Get User Data');
    zMyPost = [];

    print(zDocumentID);
    await _store.collection('Users').document(zDocumentID).get().then((value) {
      setState(() {
        print(value.data);
        String temp;
        temp = value.data['dp'];
        print('profile pic link $temp');
        if (temp.length == 0) {
          // No DP

          print('Nooo');
          profilePic =
              'https://firebasestorage.googleapis.com/v0/b/social-2-e4146.appspot.com/o/defaultFinal.jpg?alt=media&token=74dd98bd-d217-47ba-9de5-e1b839589799';
        } else {
          profilePic = temp;
          print(profilePic);
        }
        zPublic = value.data['private'];
        print(zPublic);
      });
    });
    await _store
        .collection('Post')
        .where('user', isEqualTo: zUserMail)
        .getDocuments()
        .then((value) {
      for (var i in value.documents) {
//        print(i.data);
        zMyPost.add(i.data);
      }
      setState(() {
        done = true;
      });
    });
  }

  createList() {
    print('creating list');

    String tempCategory;

    for (var i = 0; i < zCategory.length; i++) {
      tempCategory = zCategory[i];

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
    Widget yesButton = FlatButton(
      child: Text("Ok"),
      color: Colors.blueAccent,
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: kBackground,
      titleTextStyle: kTextStyle.copyWith(fontSize: 18),
      contentTextStyle: kTextStyle,
      title: Text("What is Private?"),
      content: Text(
          "If your Account is in Private people won't be able to see your post in your profile or in public unless they are your Friends. To find more people stay Extrovert. "),
      actions: [
        yesButton,
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

  changeStatus() async {
    print(zPublic);
    await _store
        .collection('Users')
        .document(zDocumentID)
        .updateData({'private': zPublic});
  }

  Future uploadPhoto() async {
    setState(() {
      uploaded = true;
    });
    List<String> userArray = [];
    userArray.add(zUserMail);

    String fileName = zUserMail;
    print(fileName);

    final StorageReference firebaseStorageRef = _storage.ref().child(fileName);
    final StorageUploadTask task =
        firebaseStorageRef.putFile(zImageToBeUploaded);
    var url = await (await task.onComplete).ref.getDownloadURL();
    print(url);
    setState(() {
      imageURL = url;
      profilePic = url;
    });

    print('after getting url');
    await _store.collection('Users').document(zDocumentID).updateData({
      'url': imageURL,
    });
    print('added to DB');
  }

  getImageCamera() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      uploadPhoto();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  getImageGallery() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      uploadPhoto();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  bottomModal() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Gallery'),
                    onTap: () async {
                      await getImageGallery();
                    }),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageCamera();
                  },
                ),
              ],
            ),
          );
        });
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
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    done = false;
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
            icon: new Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () async {
              AuthService().signOut();
              secondTime = false;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
            },
          ),
        ],
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
                      GestureDetector(
                        onTap: () {
                          print('proifile pic');
                          bottomModal();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              profilePic,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 7,
                            ),
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
                                  zUsername,
                                  style: kTextStyle.copyWith(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$zDistrict, $zState',
                                  style: kTextStyle.copyWith(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Private',
                                      style: kTextStyle,
                                    ),
                                    Switch(
                                      value: zPublic,
                                      onChanged: (value) async {
                                        setState(() {
                                          zPublic = value;
                                          print(zPublic);
                                        });
                                        await changeStatus();
                                      },
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 10),
                                        child: FaIcon(
                                          FontAwesomeIcons.infoCircle,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ],
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
                      children: myList,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, FriendsListScreen.id);
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
                              'My Friends',
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            secondTime = true;
                          });
                          Navigator.pushNamed(context, CategoryScreen.id);
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
                              'Edit Category',
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                  )
                ],
              ),
            ),
            done
                ? Expanded(
                    child: Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: zMyPost.length,
                        itemBuilder: (BuildContext context, int index) =>
                            TinyPost(
                          image: zMyPost[index]['url'],
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
