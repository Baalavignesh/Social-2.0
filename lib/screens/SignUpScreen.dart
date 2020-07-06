import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/InputBox.dart';
import 'package:newsocialmedia/reusables/bottomButton.dart';
import 'package:newsocialmedia/screens/CategoryScreen.dart';
import 'package:newsocialmedia/screens/WelcomeScreen.dart';
import 'package:newsocialmedia/services/constants.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _animationDuration = Duration(seconds: 3);
  Timer _timer;
  Color kBackgroundTop;
  Color kBackgroundBottom;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xFF403F68),
      body: AnimatedContainer(
        duration: _animationDuration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kBackgroundTop, kBackgroundBottom]),
//          color: ,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/logomain.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('New Social',
                      style: kTextStyle.copyWith(fontSize: 40)),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InputTextField(
                    hint: 'Name',
                    icon: Icon(Icons.person),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InputTextField(
                    hint: 'Mail ID',
                    icon: Icon(Icons.mail),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InputTextField(
                    hint: 'Password',
                    icon: Icon(Icons.lock),
                  ),
                ),
                Column(
                  children: <Widget>[
                    BottomButton(
                      onPress: () {
                        Navigator.pushNamed(context, CategoryScreen.id);
                      },
                      buttonText: 'Sign up',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already an user? ',
                            style: kTextStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, WelcomeScreen.id);
                            },
                            child: Text(
                              'Sign in',
                              style:
                                  kTextStyle.copyWith(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
