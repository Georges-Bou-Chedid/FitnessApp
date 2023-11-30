import 'package:fitnessapp/screens/home/diary/diary.dart';
import 'package:fitnessapp/screens/home/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/auth.dart';
import '../../controllers/user.dart';
import '../../models/UserProfile.dart';
import '../../util/theme_data.dart';
import '../splash_screen.dart';
import 'dashboard.dart';

late _HomeState settingUI;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    settingUI = this;
    return FutureBuilder<UserProfile?>(
        future: _userService.getProfile(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        // The future is still running, show a loading indicator
          return const SplashScreen();
        } else if (snapshot.hasError) {
        // An error occurred while fetching the data, show an error message
          return Text('Error: ${snapshot.error}');
        } else {
        // The data has been successfully fetched
        final userProfile = snapshot.data;
        if (userProfile != null) {
          return MaterialApp(
            theme: userProfile.darkMode ?? userProfile.darkMode == true
                ? blackTheme()
                : lightTheme(),
            initialRoute: "/dashboard",
            routes: {
              '/dashboard': (context) => const DashboardPage(),
              '/diary': (context) => const Diary(),
              '/settings': (context) => SettingsScreen(userProfile: userProfile),
            },
          );
        }
        else {
          // User profile not found
          return const Text(
            'An unexpected error occurred. Please contact support.',
            style: TextStyle(
              fontFamily: "Inter"
            ),
          );
        }
      }
    });
  }
}
