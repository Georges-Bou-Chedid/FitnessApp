import 'package:fitnessapp/widgets/settings_app_bar.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/user.dart';
import '../../../models/UserProfile.dart';
import '../../../widgets/nav_drawer.dart';
import '../../splash_screen.dart';


class SettingsScreen extends StatefulWidget {
  final UserProfile userProfile;

  const SettingsScreen({Key? key, required this.userProfile}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: MySettingsAppBar(userProfile: widget.userProfile),
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
              fontFamily: "Inter",
              fontSize: 13.5
            ),
          ),
          tiles: [
            SettingsTile(
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.5
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
              fontFamily: "Inter",
              fontSize: 13.5
            ),
          ),
          tiles: [
            SettingsTile.switchTile(
              title: const Text(
                'Dark Mode',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.5
                ),
              ),
              initialValue: widget.userProfile.darkMode,
              leading: const Icon(Icons.brightness_4),
              onToggle: (bool value) {
                setState(() {
                  UserProfile userProfile = UserProfile(
                      darkMode: !widget.userProfile.darkMode!
                  );
                  _userService.updateTheme(_userService.currentUser!.uid, userProfile).then((result) {
                    if (result) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    } else {
                      print("Theme update failed");
                    }
                  });
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
              fontSize: 13.5
            ),
          ),
          tiles: [
            SettingsTile.switchTile(
              title: const Text(
                'Receive Notifications',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.5
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
              fontFamily: "Inter",
              fontSize: 13.5
            ),
          ),
          tiles: [
            SettingsTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.5
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
              fontFamily: "Inter",
              fontSize: 13.5
            ),
          ),
          tiles: [
            SettingsTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.5
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

