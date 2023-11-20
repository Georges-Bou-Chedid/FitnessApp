import 'package:fitnessapp/screens/home/diary/diary.dart';
import 'package:fitnessapp/screens/home/settings/settings.dart';
import 'package:flutter/material.dart';
import '../../util/theme_data.dart';
import 'dashboard.dart';

late _HomeState settingUI;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDarkMode = true;

  void callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    settingUI = this;
    return MaterialApp(
      theme: isDarkMode
          ? blackTheme()
          : lightTheme(),
      initialRoute: "/dashboard",
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/diary': (context) => const Diary(),
        // '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
