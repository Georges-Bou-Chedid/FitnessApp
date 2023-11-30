import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/screens/authenticate/login_screen.dart';
import 'package:fitnessapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      navigateToMainScreen();
    });
  }

  void precacheLoginImageInSplashScreen() async {
    await precacheImage(const AssetImage('assets/images/loginbackground.jpg'), context);
  }
  void precacheDrawerImageInSplashScreen() async {
    await precacheImage(const AssetImage('assets/images/drawer/background.jpg'), context);
  }

  void navigateToMainScreen() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context){
            final user = Provider.of<User?>(context);
            if (user == null) {
              precacheLoginImageInSplashScreen();
              return const LoginPage();
            } else {
              precacheDrawerImageInSplashScreen();
              return const Home();
            }
          })
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        // color: const Color(0xFF323232),
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
      ),
    );
  }
}