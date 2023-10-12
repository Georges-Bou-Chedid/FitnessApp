import 'package:fitnessapp/screens/home/diary.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/dashboard",
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/diary': (context) => const DiaryPage(),
      },
    );
  }
}
