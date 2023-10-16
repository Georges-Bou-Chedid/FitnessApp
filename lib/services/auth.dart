import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/models/userInformation.dart";
import 'package:firebase_database/firebase_database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign up with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch(e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use');
        return "Email is already in use";
      }
      else {
        return null;
      }
    }
  }

  // create user_info table
  Future createUserInfo(String uid, userInformation userInfo) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      print(databaseReference);
      await databaseReference.child("user_information").child(uid).set({
        'gender': userInfo.gender,
        'age': userInfo.age,
        'country': userInfo.country,
        'height': userInfo.height,
        'heightUnit': userInfo.heightUnit,
        'weight': userInfo.weight,
        'weightUnit': userInfo.weightUnit
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}