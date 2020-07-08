import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/CategoryBox.dart';
import 'package:newsocialmedia/reusables/bottomButton.dart';
import 'package:newsocialmedia/screens/LoadingScreen.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'CategoryScreen';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

enum Category {
  gaming,
  books,
  movies,
  coding,
  music,
  justChatting,
  art,
  jobs,
  psvc,
  sports,
  fashion,
}
bool gaming = false;
bool book = false;
bool movies = false;
bool coding = false;
bool music = false;
bool jc = false;
bool art = false;
bool jobs = false;
bool psve = false;
bool fashion = false;
bool sport = false;
bool moreCategory = false;

createVariable() {
  print('Create Variable Functiion');
  gaming = false;
  book = false;
  movies = false;
  coding = false;
  music = false;
  jc = false;
  art = false;
  jobs = false;
  psve = false;
  fashion = false;
  sport = false;
  moreCategory = false;
  zCategory = [];
}

listItems() {
  print('Updating Interest');
  zCategory = [];
  if (gaming == true) {
    zCategory.add('Gaming');
  }
  if (book == true) {
    zCategory.add('Book');
  }
  if (movies == true) {
    zCategory.add('Movies');
  }
  if (coding == true) {
    zCategory.add('Coding');
  }
  if (music == true) {
    zCategory.add('Music');
  }
  if (jc == true) {
    zCategory.add('Just Chatting');
  }
  if (art == true) {
    zCategory.add('Art');
  }
  if (psve == true) {
    zCategory.add('Editing');
  }
  if (jobs == true) {
    zCategory.add('Jobs');
  }
  if (sport == true) {
    zCategory.add('Sports');
  }
  if (fashion == true) {
    zCategory.add('Fashion');
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _animationDuration = Duration(seconds: 3);
  Timer _timer;
  Color kBackgroundTop;
  Color kBackgroundBottom;
  bool isSelected = false;
//  final String assetName = 'images/blob.svg';

  backgroundAnimation() {
    _timer = Timer.periodic(_animationDuration, (timer) {
      final newColor1 = kBackgroundTop == Color(0xFF403F68)
          ? Color(0xFF011627)
          : Color(0xFF403F68);

      final newColor2 = kBackgroundBottom == Color(0xFF011627)
          ? Color(0xFF403F68)
          : Color(0xFF011627);

      setState(() {
        kBackgroundTop = newColor1;
        kBackgroundBottom = newColor2;
      });
    });
    kBackgroundTop = Color(0xFF403F68);
    kBackgroundBottom = Color(0xFF011627);
  }

  getData() async {
    print('Get Data FUnction');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    zCategory = (prefs.getStringList('category'));
    print(zCategory);
    print('$zUsername and $zUserMail and $zCategory');
    if (zCategory != null) {
      for (var i in zCategory) {
        print('Category : $i');
        setState(() {
          moreCategory = true;
          if (i == "Gaming") {
            gaming = true;
          }
          if (i == "Book") {
            book = true;
          }
          if (i == "Movies") {
            movies = true;
          }
          if (i == "Coding") {
            coding = true;
          }
          if (i == "Music") {
            music = true;
          }
          if (i == "Just Chatting") {
            jc = true;
          }
          if (i == "Art") {
            art = true;
          }
          if (i == "Editing") {
            psve = true;
          }
          if (i == "Jobs") {
            jobs = true;
          }
        });
        print(i);
      }
      print('$gaming $book $movies $coding $music $jc $art $psve $jobs');
      print(jc);
    } else {
      print('Empty Category');
      zCategory = [];
    }
  }

  selectedCategory(Category selected) {
    print(zCategory);
    setState(() {
      if (selected == Category.gaming) {
        gaming = gaming ? false : true;
      }
      if (selected == Category.books) {
        book = book ? false : true;
      }
      if (selected == Category.movies) {
        movies = movies ? false : true;
      }
      if (selected == Category.coding) {
        coding = coding ? false : true;
      }
      if (selected == Category.music) {
        music = music ? false : true;
      }
      if (selected == Category.justChatting) {
        jc = jc ? false : true;
      }
      if (selected == Category.art) {
        art = art ? false : true;
      }
      if (selected == Category.psvc) {
        psve = psve ? false : true;
      }
      if (selected == Category.sports) {
        sport = sport ? false : true;
      }
      if (selected == Category.fashion) {
        fashion = fashion ? false : true;
      }
      if (selected == Category.jobs) {
        jobs = jobs ? false : true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print('Category Screen');
    createVariable();
    getData();
    backgroundAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _store = Firestore.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: _animationDuration,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kBackgroundTop, kBackgroundBottom]),
//          color: ,
          ),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 60, 30, 15),
                      child: Text(
                        secondTime
                            ? 'Update your point of interest'
                            : 'Choose your point of interest',
                        style: kTextStyle.copyWith(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                CategoryBox(
                                  icon: Icons.gamepad,
                                  text: 'Gaming',
                                  color: Colors.blueAccent,
                                  onPress: () {
                                    // Button Action
                                    selectedCategory(Category.gaming);
                                  },
                                  selected: gaming,
                                ),
                                CategoryBox(
                                  icon: Icons.book,
                                  text: 'Books/ Poetry',
                                  color: Colors.purpleAccent,
                                  selected: book,
                                  onPress: () {
                                    selectedCategory(Category.books);
                                  },
                                ),
                                CategoryBox(
                                  icon: Icons.movie,
                                  text: 'Movies & Series',
                                  color: Colors.green,
                                  selected: movies,
                                  onPress: () {
                                    selectedCategory(Category.movies);
                                  },
                                ),
                                CategoryBox(
                                  icon: Icons.code,
                                  text: 'Coding',
                                  color: Colors.orangeAccent,
                                  selected: coding,
                                  onPress: () {
                                    selectedCategory(Category.coding);
                                  },
                                ),
                                CategoryBox(
                                  icon: Icons.music_note,
                                  text: 'Music',
                                  color: Colors.pinkAccent,
                                  selected: music,
                                  onPress: () {
                                    selectedCategory(Category.music);
                                  },
                                ),
                                moreCategory
                                    ? Wrap(
                                        children: <Widget>[
                                          CategoryBox(
                                            icon: Icons.phone_in_talk,
                                            text: 'Just Chatting',
                                            color: Colors.redAccent,
                                            selected: jc,
                                            onPress: () {
                                              selectedCategory(
                                                  Category.justChatting);
                                            },
                                          ),
                                        ],
                                      )
                                    : CategoryBox(
                                        icon: Icons.add,
                                        text: 'Show More',
                                        selected: jc,
                                        color: Colors.redAccent,
                                        onPress: () {
                                          setState(() {
                                            moreCategory = true;
                                          });
                                        },
                                      ),
                                moreCategory
                                    ? Wrap(
                                        children: <Widget>[
                                          CategoryBox(
                                            icon: Icons.brush,
                                            text: 'Art',
                                            color: Colors.redAccent,
                                            selected: art,
                                            onPress: () {
                                              selectedCategory(Category.art);
                                            },
                                          ),
                                          CategoryBox(
                                            icon: Icons.attach_file,
                                            text: 'Jobs',
                                            color: Colors.blueAccent,
                                            selected: jobs,
                                            onPress: () {
                                              selectedCategory(Category.jobs);
                                            },
                                          ),
                                          CategoryBox(
                                            icon: Icons.camera,
                                            text: 'Photoshop & Video Editing',
                                            color: Colors.purpleAccent,
                                            selected: psve,
                                            onPress: () {
                                              selectedCategory(Category.psvc);
                                            },
                                          ),
                                          CategoryBox(
                                            icon: Icons.wb_sunny,
                                            text: 'Sports',
                                            color: Colors.orangeAccent,
                                            selected: sport,
                                            onPress: () {
                                              selectedCategory(Category.sports);
                                            },
                                          ),
                                          CategoryBox(
                                            icon: Icons.perm_contact_calendar,
                                            text: 'Fashion & Design',
                                            color: Colors.green,
                                            selected: fashion,
                                            onPress: () {
                                              selectedCategory(
                                                  Category.fashion);
                                            },
                                          ),
                                        ],
                                      )
                                    : Text(' ')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: BottomButton(
                        buttonText: secondTime ? 'Update Interest' : 'Next',
                        onPress: () async {
                          await listItems();
                          //Navigate Here
//                          print(category);
                          if (secondTime == false) {
                            await _store.collection('Users').add({
                              'mail': zUserMail,
                              'username': zUsername,
                              'category': zCategory,
                            });
                            Navigator.pushReplacementNamed(
                                context, LoadingScreen.id);
                          } else {
                            print('second time. Merging');
                            print(zDocumentID);
                            print(zCategory);
                            await _store
                                .collection('Users')
                                .document(zDocumentID)
                                .updateData({'category': zCategory});
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setStringList('category', zCategory);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
