import 'dart:convert';

import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/models/UserProfile.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';


class UserService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user_profile table
  Future createUserProfile(String uid, UserProfile userProfile) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child("user_profile").child(uid).set({
        'name': userProfile.name,
        'user_name': userProfile.userName,
        'phone_number': userProfile.phoneNumber,
        'gender': userProfile.gender,
        'age': userProfile.age,
        'country': userProfile.country,
        'height': userProfile.height,
        'weight': userProfile.weight,
        'measurement_system': userProfile.measurementSystem,
        'created_at': getTimestamp(),
        'updated_at': getTimestamp()
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  User? get currentUser => _auth.currentUser;

  String? get userUid => currentUser?.uid;

  Future<UserProfile?> getUserProfile() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("user_profile/$userUid");
      DatabaseEvent event = await ref.once();

      if (event.snapshot.value != null) {
        Map<String?, dynamic> userData = json.decode(json.encode(event.snapshot.value));

        UserProfile userProfile = UserProfile.fromMap(userData);
        return userProfile;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

String getTimestamp() {
  final now = DateTime.now();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
}