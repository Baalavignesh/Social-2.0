import 'package:flutter/material.dart';
import 'package:newsocialmedia/services/constants.dart';

Container profileCategory(
  IconData icon,
  String name,
  Color color,
) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Container(
        height: height / 8,
        width: height / 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Material(
                borderRadius: BorderRadius.circular(40),
                elevation: 10,
                child: Container(
                  child: Center(
                    child: Icon(
                      icon,
                      size: 25,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 45,
                  width: 45,
                ),
              ),
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
