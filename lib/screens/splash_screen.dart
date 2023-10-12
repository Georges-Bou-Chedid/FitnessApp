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
    navigateToMainScreen();
    // Add any initialization code here
    // Typically, you might load data or perform some setup tasks

    // Redirect to the login/signup screen after a delay
  }

  void navigateToMainScreen() {
    // Navigate to the main screen or the screen where you want to use CountryPickerDropdown
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context){
            final user = Provider.of<User?>(context);
            if (user == null) {
              return const LoginPage();
            } else {
              return Home();
            }
          })
      );
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
            colors: [Color(0xFFFFDE8D), Color(0xFFFFA427)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/b.png',
                width: 250.0,
                height: 250.0,
              ), // Replace with your logo path
              // const SizedBox(height: 20.0),
              const CircularProgressIndicator(
                  color: Colors.white
              ), // Add a loading indicator if needed
            ],
          ),
        )
      ),
    );
  }
}