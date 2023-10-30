import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/splash_screen.dart';
import '../services/auth.dart';

class MyAppBar extends StatefulWidget {
  final List<Tab> selectedTabs;
  const MyAppBar({super.key, required this.selectedTabs});

  @override
  MyAppBarPage createState() => MyAppBarPage();
}

class MyAppBarPage extends State<MyAppBar> {
  final AuthService _authService = AuthService();

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  TabBar? tabBar() {
    if (widget.selectedTabs.isEmpty) {
      return null;
    }
    return TabBar(
        tabs: widget.selectedTabs.map((tab) {
          return Tab(
            child: Text(
              tab.text!,
              style: const TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 16
              ),
            ),
          );
        }).toList(),
        labelColor: Colors.grey[300],
        unselectedLabelColor: const Color(0xFF323232),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: Colors.grey[300]!), // Set the line width and color
      ),
    );
  }

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
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: GestureDetector(
            onTap: () {
              final currentRouteName = ModalRoute.of(context)!.settings.name;
              if (currentRouteName != "/dashboard") {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            },
            child: Image.asset(
              'assets/images/nutrilebblack.png',
              width: 130.0,
              height: 130.0,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.user,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
          ],
          bottom: tabBar()
        )
    );
  }
}