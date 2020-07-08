import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAccount(BuildContext context) async {
    String displayError = "Verify Email";
    try {
      await _auth
          .createUserWithEmailAndPassword(email: nEmail, password: nPassword)
          .then((value) => value.user.sendEmailVerification())
          .catchError((error) {
        print(error.message);
        if (error.message == "The email address is badly formatted.") {
          displayError = "Enter a valid E-Mail";
        } else if (error.message ==
            "The given password is invalid. [ Password should be at least 6 characters ]") {
          displayError = "Password should be at least 6 characters";
        } else if (error.message ==
            "The email address is already in use by another account.") {
          displayError = "Email ID already used";
        } else {
          print('nothing');
        }
      });
    } catch (e) {
      print(e);
      print('Already Existing');
    }
    return displayError;
  }

  Future signIn(BuildContext context) async {
    var displayError = " ";
    var authenticatedUser;
    try {
      authenticatedUser = await _auth
          .signInWithEmailAndPassword(
              email: 'baalavignesh21@gmail.com', password: 'asdfghjkl')
          .then((value) {
        if (value.user.isEmailVerified == true) {
          print('Verified');
          isMailVerified = true;
        } else {
          print("please verify");
          displayError = "Verify your Mail";
          isMailVerified = false;
        }
      }).catchError((error) {
        print(error.message);
        if (error.message == "The email address is badly formatted.") {
          displayError = "Enter a valid E-Mail";
        } else if (error.message ==
            "The password is invalid or the user does not have a password.") {
          displayError = "Wrong Password";
        } else {
          displayError = " ";
        }
        Future.delayed(Duration(seconds: 5), () {
          print(authenticatedUser.additionalUserInfo);
          print('checking first time');
        });
      });
    } catch (e) {
      print(e);
    }
    return displayError;
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
