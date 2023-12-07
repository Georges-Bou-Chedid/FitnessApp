import 'dart:convert';
import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/models/UserProfile.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class UserService extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<UserProfile?> getProfile(userUid) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("user_profile/$userUid");
      DatabaseEvent event = await ref.once();

      if (event.snapshot.value != null) {
        Map<String?, dynamic> userData = json.decode(json.encode(event.snapshot.value));

        UserProfile userProfile = UserProfile.fromMap(userData);
        _userProfile = userProfile;

        notifyListeners();
        return userProfile;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> createProfile(String uid, UserProfile userProfile) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child("user_profile").child(uid).set({
        'name': userProfile.name,
        'phone_number': userProfile.phoneNumber,
        'gender': userProfile.gender,
        'age': userProfile.age,
        'country': userProfile.country,
        'height': userProfile.height,
        'weight': userProfile.weight,
        'measurement_system': userProfile.measurementSystem,
        'dark_mode': userProfile.darkMode,
        'created_at': getTimestamp(),
        'updated_at': getTimestamp()
      });
      _userProfile = userProfile;

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateTheme(String uid, UserProfile userProfile) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child("user_profile").child(uid).update({
        'dark_mode': userProfile.darkMode,
      });

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateProfile(String uid, UserProfile userProfile) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      final Map<String, dynamic> updateData = {};

      if (userProfile.name != null) updateData['name'] = userProfile.name;
      if (userProfile.phoneNumber != null) updateData['phone_number'] = userProfile.phoneNumber;

      await databaseReference.child("user_profile").child(uid).update(updateData);
      _userProfile = _userProfile?.copyWith(updateData);

      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

String getTimestamp() {
  final now = DateTime.now();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
}