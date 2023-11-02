import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navdrawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323232),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: MyAppBar(selectedTabs: []),
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF323232), // Dark Gray
              Color(0xFF444444), // Slightly lighter shade of gray
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: Colors.grey[350]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
