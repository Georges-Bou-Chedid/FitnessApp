import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({super.key});

  final AuthService _authService = AuthService();

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
      backgroundColor: const Color(0xFFC1E1C1),
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
    );
  }
}