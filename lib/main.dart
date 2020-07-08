import 'package:flutter/material.dart';
import 'package:newsocialmedia/screens/CategoryScreen.dart';
import 'package:newsocialmedia/screens/FriendsListScreen.dart';
import 'package:newsocialmedia/screens/FriendsPostScreen.dart';
import 'package:newsocialmedia/screens/LoadingScreen.dart';
import 'package:newsocialmedia/screens/MainRoutePage.dart';
import 'package:newsocialmedia/screens/MapScreen.dart';
import 'package:newsocialmedia/screens/PublicPostScreen.dart';
import 'package:newsocialmedia/screens/SignUpScreen.dart';
import 'package:newsocialmedia/screens/UserProfileScreen.dart';
import 'package:newsocialmedia/screens/WelcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
        MainRoutePage.id: (context) => MainRoutePage(),
        PublicPostScreen.id: (context) => PublicPostScreen(),
        FriendsPostScreen.id: (context) => FriendsPostScreen(),
        MapScreen.id: (context) => MapScreen(),
        FriendsListScreen.id: (context) => FriendsListScreen(),
        UserProfileScreen.id: (context) => UserProfileScreen(),
      },
    );
  }
}
