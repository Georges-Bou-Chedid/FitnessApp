import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: const Text(
            'Fitness App',
            style: TextStyle(
              // fontSize: 10.0,
              fontFamily: "BebasNeue",
            ),
          ),
          backgroundColor: const Color(0xFFFF9800),
          elevation: 0.0,
          actions: <Widget>[
            // Add your action widgets here
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}