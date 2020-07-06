import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/CategoryBox.dart';
import 'package:newsocialmedia/reusables/bottomButton.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/services/constants.dart';

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
bool moreCategory = false;

listItems() {
  if (gaming == true) {
    category.add('Gaming');
  }
  if (book == true) {
    category.add('Book');
  }
  if (movies == true) {
    category.add('Movies');
  }
  if (coding == true) {
    category.add('Coding');
  }
  if (music == true) {
    category.add('Music');
  }
  if (jc == true) {
    category.add('Just Chatting');
  }
  if (art == true) {
    category.add('Just Chatting');
  }
  if (psve == true) {
    category.add('Editing');
  }
  if (jobs == true) {
    category.add('Jobs');
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

  @override
  void initState() {
    super.initState();
    backgroundAnimation();
  }

  selectedCategory(Category selected) {
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
  Widget build(BuildContext context) {
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
                        'Choose your point of interest',
                        style: kTextStyle.copyWith(fontSize: 30),
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
                        buttonText: 'Next',
                        onPress: () {
                          listItems();
                          //Navigate Here
                          print(category);
                          Navigator.pushNamed(context, MainRoutePage.id);
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
