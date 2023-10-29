import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFFFFF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/navdrawerbackground.jpg'))), child: null,
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.gaugeSimpleHigh, // The icon you want to use
              size: 30, // Icon size
              color: Colors.blue, // Icon color
            ),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                  fontFamily: "Inter",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const FaIcon(
            FontAwesomeIcons.book, // The "book" icon represents a diary
            size: 30, // Icon size
            color: Colors.blue, // Icon color
            ),
            title: const Text(
              'Diary',
              style: TextStyle(
                fontFamily: "Inter",
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushReplacementNamed(context, '/diary');
            },
          ),
        ],
      ),
    );
  }
}