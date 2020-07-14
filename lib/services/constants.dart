import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Variable Reference
// uVariable - NearMe People
// xVariable - Temporary Friends Variable
// yVariable - Friends Reference Variable
// zVariable - User Variable

TextStyle kTextStyle = TextStyle(fontSize: 14, fontFamily: 'Avenir');
Color selectedCard = Colors.blueGrey;
Color kBackground = Color(0xFF333B48);
Color kDarkBackground = Color(0xFF011627);
double sHeight;
double sWidth;
bool back = false;

// Initial Constants of using User

bool isMailVerified;
String nEmail, nPassword;
String zUsername;
String zUserMail;
String zPassword;
String zDocumentID;
List<String> zCategory = [];
String zCountry, zState, zDistrict;
double zLatitude, zLongitude;
File zImageToBeUploaded;
List<String> zSelected = [];
String zCaption = ' ';
List<Map<String, dynamic>> zMyPost = [];
bool zPublic = false;
String zURL;

String errorMessages = " ";
bool warning = false;
bool secondTime = false;
bool isMe = true;
int clickedIndex;
bool dialVisible = true;

// Near Me People

List<Map<String, dynamic>> uNearMe = [];
List<String> uNearMeName = [];
List<String> uNearMeMail = [];
List<String> uNearMeDocID = [];
List<Container> uNearMeList = [];

// Friend Request Received

List<Map<String, dynamic>> aFriendRequest = [];
List<String> aFriendRequestName = [];
List<String> aFriendRequestDocID = [];
List<Container> aFriendRequestList = [];
List<String> aFriendRequestMail = [];

// Friends and Chat

List<Map<String, dynamic>> zFriends = [];
List<String> zFriendsMail = [];
List<String> zFriendsDocID = [];
List<Map<String, dynamic>> zFriendsPost = [];

// Public Post

List<String> zPublicPostMail = [];
