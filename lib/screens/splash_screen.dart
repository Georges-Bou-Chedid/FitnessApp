import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/screens/authenticate/login_screen.dart';
import 'package:fitnessapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth.dart';
import '../controllers/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _delayCompleted = false;

  @override
  void initState() {
    super.initState();
    // Add a delay of 10 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _delayCompleted = true;
        });
      }
    });
  }

  void precacheLoginImageInSplashScreen() async {
    await precacheImage(const AssetImage('assets/images/loginbackground.jpg'), context);
  }
  void precacheDrawerImageInSplashScreen() async {
    await precacheImage(const AssetImage('assets/images/drawer/background.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !_delayCompleted) {
            precacheDrawerImageInSplashScreen();
            precacheLoginImageInSplashScreen();

            return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3FCC7C),
                      Color(0xFFBCFF5C)
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/nutrilebblack.png',
                        width: 250.0,
                        height: 250.0,
                      ),
                      const CircularProgressIndicator(
                          color: Color(0xFF323232)
                      ),
                    ],
                  ),
                )
            );
          } else {
            // If the user is logged in, display authenticated content
            if (snapshot.data != null) {
              return ChangeNotifierProvider(
                create: (context) => UserService(),
                child: const Home(),
              );
            }
            // If the user is not logged in, display non-authenticated content
            else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}