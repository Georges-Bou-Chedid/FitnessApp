import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: const Color(0xFF323232),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: const EdgeInsets.all(0), // Remove any padding around the image
                    margin: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/navdrawerbackground.jpg'),
                          ),
                        ),
                      ),
                    ), // Remove any margin around the image
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.gaugeSimpleHigh, // The icon you want to use
                      size: 30, // Icon size
                      color: Color(0xFF3FCC7C), // Icon color
                    ),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: Color(0xFFFFFFFF)
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
                      color: Color(0xFF3FCC7C), // Icon color
                    ),
                    title: const Text(
                      'Diary',
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: Color(0xFFFFFFFF)
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushReplacementNamed(context, '/diary');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star, size: 30, color: Colors.yellow),
                    title: const Text(
                      'Health Guidance',
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    onTap: () {
                      // Handle onTap for the ListTile with the recommendations icon
                    },
                  )
                ]
            )
          ),
          ListTile(
            leading: const Icon(Icons.settings, size: 30, color: Color(0xFF3FCC7C)),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontFamily: "Inter",
                color: Color(0xFFFFFFFF),
              ),
            ),
            onTap: () {
              // Handle onTap for the bottom ListTile
            },
          ),
        ],
      ),
    );
  }
}