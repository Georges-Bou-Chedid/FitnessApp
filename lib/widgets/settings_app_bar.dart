import 'package:flutter/material.dart';

class MySettingsAppBar extends StatefulWidget {
  const MySettingsAppBar({super.key});

  @override
  MySettingsAppBarPage createState() => MySettingsAppBarPage();
}

class MySettingsAppBarPage extends State<MySettingsAppBar> {
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'), // Replace with your profile image
                      ),
                      SizedBox(width: 10), // Add some spacing between the avatar and email
                      Text(
                        "example@hotmail.com\n71941695",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
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
              fontSize: 22,
              fontWeight: FontWeight.w500
            ),
          ),
          elevation: 0.0,
          centerTitle: false,
        )
    );
  }
}