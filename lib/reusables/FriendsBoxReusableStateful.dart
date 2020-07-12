import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/screens/FriendsUserScreen.dart';
import 'package:newsocialmedia/screens/UserProfileScreenNearMe.dart';
import 'package:newsocialmedia/screens/UserProfileScreenRequest.dart';
import 'package:newsocialmedia/services/constants.dart';

class FriendBoxStateful extends StatefulWidget {
  final profilePic;
  final uFriend;
  final uDistrict;
  final uState;
  final uCategory;
  final nearMe;
  final uMail;
  FriendBoxStateful(
      {this.profilePic,
      this.uFriend,
      this.uDistrict,
      this.uState,
      this.uCategory,
      this.nearMe,
      this.uMail});
  @override
  _FriendBoxStatefulState createState() => _FriendBoxStatefulState();
}

class _FriendBoxStatefulState extends State<FriendBoxStateful> {
  final _store = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          onTap: () {
            clickedIndex = zFriendsMail.indexOf(this.widget.uMail);
            print(clickedIndex);
            Navigator.pushNamed(context, FriendUserScreen.id);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.indigo, Colors.cyan])),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.smile,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this.widget.uFriend,
                                    style: kTextStyle.copyWith(
                                        fontSize: 20, fontFamily: 'AvenirSemi'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    this.widget.uCategory,
                                    style: kTextStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      '${this.widget.uDistrict}, ${this.widget.uState}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.angleRight,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
