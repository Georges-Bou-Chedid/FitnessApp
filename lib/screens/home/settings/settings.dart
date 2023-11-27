import 'package:fitnessapp/widgets/settings_app_bar.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../../models/UserProfile.dart';
import '../../../services/auth.dart';
import '../../../services/user.dart';
import '../../../widgets/nav_drawer.dart';
import '../../splash_screen.dart';
import '../home.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
        future: _userService.getUserProfile(),
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
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: MySettingsAppBar(userProfile: userProfile),
            ),
            drawer: const SizedBox(
              width: 250,
              child: NavDrawer()
            ),
            body: SettingsList(
            lightTheme: const SettingsThemeData(
            settingsListBackground: Color(0xFFFFFFFF),
            settingsSectionBackground: Color(0xFFFFFFFF),
            titleTextColor: Color(0xFF323232)
            ),
            darkTheme: const SettingsThemeData(
            settingsListBackground: Color(0xFF323232),
            settingsSectionBackground: Color(0xFF323232)
            ),
            sections: [
              SettingsSection(
                title: const Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: "Inter"
                  ),
                ),
                tiles: [
                  SettingsTile(
                      title: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16
                        ),
                      ),
                      leading: const Icon(Icons.edit),
                      onPressed: (context) {

                      }
                  ),
                ],
              ),
              SettingsSection(
                title: const Text(
                  'Theme',
                  style: TextStyle(
                      fontFamily: "Inter"
                  ),
                ),
                tiles: [
                  SettingsTile.switchTile(
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16
                      ),
                    ),
                    initialValue: isDarkMode,
                    leading: const Icon(Icons.brightness_4),
                    onToggle: (bool value) {
                      setState(() {
                        if (isDarkMode == false) {
                          isDarkMode = true;
                        } else {
                          isDarkMode = false;
                        }
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: const Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontFamily: "Inter",
                  ),
                ),
                tiles: [
                  SettingsTile.switchTile(
                    title: const Text(
                      'Receive Notifications',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16
                      ),
                    ),
                    initialValue: false,
                    leading: const Icon(Icons.notifications),
                    onToggle: (bool value) {
                      // Implement notification settings logic
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: const Text(
                  'About',
                  style: TextStyle(
                      fontFamily: "Inter"
                  ),
                ),
                tiles: [
                  SettingsTile(
                      title: const Text(
                        'About Us',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16
                        ),
                      ),
                      leading: const Icon(Icons.info),
                      onPressed: (context) {

                      }
                  ),
                ],
              ),
              SettingsSection(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: "Inter"
                  ),
                ),
                tiles: [
                  SettingsTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16
                      ),
                    ),
                    leading: const Icon(Icons.exit_to_app),
                    onPressed: (context) async {
                      await _authService.signOut();
                    },
                  ),
                ],
              ),
            ],
            ),
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

