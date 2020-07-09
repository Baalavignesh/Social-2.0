import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/screens/UserProfileScreenNearMe.dart';
import 'package:newsocialmedia/screens/UserProfileScreenRequest.dart';
import 'package:newsocialmedia/services/constants.dart';
import '../tabs/FriendRequestTab.dart';

final _store = Firestore.instance;

Container friendsBox(FaIcon profilePic, String uFriend, String uDistrict,
    String uState, String uCategory, BuildContext context, bool nearMe) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          print(aFriendRequestName);
          print(aFriendRequestName.indexOf(uFriend));
          nearMe
              ? clickedIndex = uNearMeName.indexOf(uFriend)
              : clickedIndex = aFriendRequestName.indexOf(uFriend);

          nearMe
              ? Navigator.pushNamed(context, UserProfileScreenNearMe.id)
              : Navigator.pushNamed(context, UserProfileScreenRequest.id);
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
                                  uFriend,
                                  style: kTextStyle.copyWith(
                                      fontSize: 20, fontFamily: 'AvenirSemi'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  uCategory,
                                  style: kTextStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('$uDistrict, $uState'),
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
