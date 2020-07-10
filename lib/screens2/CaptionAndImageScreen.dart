import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsocialmedia/reusables/MiniCategory.dart';
import 'package:newsocialmedia/screens/FriendsPostScreen.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/services/constants.dart';

class CaptionAndImageScreen extends StatefulWidget {
  static const String id = 'CaptionAndImageScreen';

  @override
  _CaptionAndImageScreenState createState() => _CaptionAndImageScreenState();
}

class _CaptionAndImageScreenState extends State<CaptionAndImageScreen> {
  bool isPhoto = true;
  Timestamp time;
  final _storage = FirebaseStorage.instance;
  final _store = Firestore.instance;
  bool uploaded = false;
  String imageURL;
  bool uploading = false;

  Future uploadPhoto() async {
    setState(() {
      uploaded = true;
    });
    time = Timestamp.now();

    print('UserMail $zUserMail');
    print('Selected Category : $zSelected');
    print('Caption $zCaption');
    print('Is Photo $isPhoto');
    print(time);

    String fileName = zUserMail + time.toString();
    print(fileName);

    final StorageReference firebaseStorageRef = _storage.ref().child(fileName);
    final StorageUploadTask task =
        firebaseStorageRef.putFile(zImageToBeUploaded);
    var url = await (await task.onComplete).ref.getDownloadURL();
    print(url);
    setState(() {
      imageURL = url;
    });

    print('after getting url');
    await _store.collection('Post').add({
      'user': zUserMail,
      'caption': zCaption,
      'post category': zSelected,
      'is photo': isPhoto,
      'timestamp': time,
      'url': imageURL,
    }).then((value) {
      setState(() {
        uploaded = true;
        Navigator.pushReplacementNamed(context, MainRoutePage.id);
      });
    });
    print('added to DB');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    zSelected = [];
    time = null;
    zCaption = ' ';
    uploaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return uploaded
        ? Scaffold(
            backgroundColor: kDarkBackground,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Uploading Picture...',
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
          )
        : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: kDarkBackground,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              zImageToBeUploaded,
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 30),
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Say something',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                onChanged: (value) {
                                  zCaption = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Select Category (Max 3)',
                                style: kTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Wrap(
                                children: zCategory
                                    .map(
                                      (item) => MiniCategory(
                                        name: item,
                                      ),
                                    )
                                    .toList()
                                    .cast<Widget>(),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    print(zSelected);
                                    uploadPhoto();
                                  },
                                  child: Container(
                                    width: sWidth / 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.indigo,
                                              Colors.cyan
                                            ])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Center(
                                        child: Text(
                                          'Post',
                                          style:
                                              kTextStyle.copyWith(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
