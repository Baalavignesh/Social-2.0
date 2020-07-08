import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/services/constants.dart';

Container friendsBox(FaIcon profilePic, String uFriend, String uDistrict,
    String uState, String uCategory) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(12),
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
                          style:
                              kTextStyle.copyWith(fontWeight: FontWeight.w600),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Material(
                  borderRadius: BorderRadius.circular(4),
//                        color: Color(0xFFA52647),
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Follow'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
