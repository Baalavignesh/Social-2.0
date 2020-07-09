import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsocialmedia/reusables/bottomButton.dart';
import 'package:newsocialmedia/services/MailAuth.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                    child: Text(
                      'New Social',
                      style: kTextStyle.copyWith(fontSize: 40),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  warning
                      ? Text(errorMessages,
                          style: kTextStyle.copyWith(fontSize: 18))
                      : Text(' '),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onChanged: (value) {
                        zUsername = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: 'Mail ID',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onChanged: (value) {
                        nEmail = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onChanged: (value) {
                        nPassword = value;
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      BottomButton(
                        onPress: () async {
                          print('$zUsername $nEmail $nPassword');
                          if (zUsername != null &&
                              nEmail != null &&
                              nPassword != null &&
                              zUsername != " ") {
                            print("ah yes");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('username', zUsername);
                            errorMessages =
                                await AuthService().createAccount(context);
                            if (errorMessages != "Verify Email") {
                              print('some error is there');
                              print(errorMessages);
                              warning = true;
                            } else {
                              print('No error. Verify the mail');
                              Navigator.pop(context);
                            }
                          } else {
                            setState(() {
                              warning = true;
                              errorMessages = "Enter the Details";
                            });
                          }
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
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign in',
                                style: kTextStyle.copyWith(
                                    color: Colors.blueAccent),
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
      ),
    );
  }
}
