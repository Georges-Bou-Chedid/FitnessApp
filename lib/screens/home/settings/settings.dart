import 'package:fitnessapp/widgets/settings_app_bar.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../../services/auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: MySettingsAppBar(),
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
}

