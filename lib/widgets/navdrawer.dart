import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color(0xFFD3D3D3),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/food.png'))), child: null,
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.gaugeSimpleHigh, // The icon you want to use
              size: 30, // Icon size
              color: Colors.blue, // Icon color
            ),
            title: const Text('Dashboard'),
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
            title: const Text('Diary'),
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