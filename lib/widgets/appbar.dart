import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth.dart';

class MyAppBar extends StatefulWidget {
  final List<Tab> selectedTabs;
  const MyAppBar({super.key, required this.selectedTabs});

  @override
  MyAppBarPage createState() => MyAppBarPage();
}

class MyAppBarPage extends State<MyAppBar> {
  final AuthService _authService = AuthService();

  TabBar? tabBar() {
    if (widget.selectedTabs.isEmpty) {
      return null;
    }
    return TabBar(
        tabs: widget.selectedTabs,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: GestureDetector(
        onTap: () {
          final currentRouteName = ModalRoute.of(context)!.settings.name;
          if (currentRouteName != "/dashboard") {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        },
        child: Image.asset(
          'assets/images/b.png',
          width: 150.0,
          height: 150.0,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0.0,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.user,
            size: 22,
            color: Colors.black,
          ),
          onPressed: () async {
            await _authService.signOut();
          },
        ),
      ],
      bottom: tabBar()
    );
  }
}