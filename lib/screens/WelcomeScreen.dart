import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/bottomButton.dart';
import 'package:newsocialmedia/screens/LoadingScreen.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/screens/SignUpScreen.dart';
import 'package:newsocialmedia/services/MailAuth.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    print('Welcome Screen');
    backgroundAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  height: 100,
                  width: 100,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/logomain.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Social 2.0',
                      style: kTextStyle.copyWith(fontSize: 40)),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                warning
                    ? Text(errorMessages, style: kTextStyle.copyWith(fontSize: 18))
                    : Text(' '),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onChanged: (value) {
                      zUserMail = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onChanged: (value) {
                      zPassword = value;
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    BottomButton(
                      buttonText: 'Sign in',
                      onPress: () async {
                        // Navigate here
                        print(zUserMail);
                        print(zPassword);
                        if (zUserMail != null && zPassword != null) {
                          errorMessages = await AuthService().signIn(context);
                          print(errorMessages);
                          if (errorMessages != " ") {
                            warning = true;
                          } else {
                            if (isMailVerified == true) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('mail', zUserMail);
                              Navigator.pushReplacementNamed(
                                  context, LoadingScreen.id);
                            } else {
                              print('Verify the Mail');
                              Navigator.pushNamed(context, WelcomeScreen.id);
                            }
                          }
                        } else {
                          setState(() {
                            warning = true;
                            errorMessages = "Enter Mail ID and Password";
                          });
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account? ',
                            style: kTextStyle.copyWith(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Text(
                              'Sign up',
                              style: kTextStyle.copyWith(
                                  color: Colors.blueAccent, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: kTextStyle.copyWith(
                                  color: Colors.blueAccent, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
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
