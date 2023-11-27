import 'package:flutter/material.dart';
import '../models/UserProfile.dart';
import '../services/user.dart';

class MySettingsAppBar extends StatefulWidget {
  final UserProfile userProfile;

  const MySettingsAppBar({super.key, required this.userProfile});

  @override
  MySettingsAppBarPage createState() => MySettingsAppBarPage();
}

class MySettingsAppBarPage extends State<MySettingsAppBar> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3FCC7C),
                  Color(0xFFBCFF5C),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align at the bottom of the flexibleSpace
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the start (left) of the flexibleSpace
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'), // Replace with your profile image
                      ),
                      const SizedBox(width: 10), // Add some spacing between the avatar and email
                      Text(
                        "${_userService.currentUser?.email}\n${widget.userProfile.phoneNumber}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                      const SizedBox(width: 50),
                      const Text(
                        "Gained 0 kg",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Account',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "BebasNeue",
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
          ),
          elevation: 0.0,
          centerTitle: false,
          actions: <Widget>[
            Image.asset(
              'assets/images/nutrilebblack.png', // Replace with your app's logo
              width: 100.0,
              height: 100.0,
            ),
          ],
        )
    );
  }
}