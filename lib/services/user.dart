import "package:firebase_auth/firebase_auth.dart";
import "package:fitnessapp/models/UserInformation.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';


class UserService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user_information table
  Future createUserInfo(String uid, UserInformation userInfo) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child("user_information").child(uid).set({
        'gender': userInfo.gender,
        'age': userInfo.age,
        'country': userInfo.country,
        'height': userInfo.height,
        'heightUnit': userInfo.heightUnit,
        'weight': userInfo.weight,
        'weightUnit': userInfo.weightUnit,
        'created_at': getTimestamp(),
        'updated_at': getTimestamp()
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}

String getTimestamp() {
  final now = DateTime.now();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
}