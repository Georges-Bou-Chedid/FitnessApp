import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
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
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/navdrawerbackground.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.gaugeSimpleHigh,
                      color: Color(0xFF3FCC7C),
                      size: 30
                    ),
                    title: const Text('Dashboard'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.book,
                      color: Color(0xFF3FCC7C),
                      size: 30,
                    ),
                    title: const Text('Diary'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushReplacementNamed(context, '/diary');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star, size: 30, color: Colors.yellow),
                    title: const Text('Health Guidance'),
                    onTap: () {
                      // Handle onTap for the ListTile with the recommendations icon
                    },
                  )
                ]
            )
          ),
          ListTile(
            leading: const Icon(Icons.settings, size: 30, color: Color(0xFF3FCC7C),),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}