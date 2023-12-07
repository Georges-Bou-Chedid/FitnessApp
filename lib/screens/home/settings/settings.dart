import 'package:fitnessapp/widgets/settings_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/user.dart';
import '../../../models/UserProfile.dart';
import '../../../widgets/nav_drawer.dart';
import '../../splash_screen.dart';
import 'edit_profile.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserService>(context, listen: false);

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
                  Navigator.of(context).push(_editProfileRoute());
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
              initialValue: userProfileProvider.userProfile?.darkMode,
              leading: const Icon(Icons.brightness_4),
              onToggle: (bool value) {
                setState(() {
                  UserProfile userProfile = UserProfile(
                      darkMode: !userProfileProvider.userProfile!.darkMode!
                  );
                  userProfileProvider.updateTheme(_authService.getCurrentUser()!.uid, userProfile).then((result) {
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

PageRouteBuilder<dynamic> _editProfileRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EditProfilePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Slide in from the bottom
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

