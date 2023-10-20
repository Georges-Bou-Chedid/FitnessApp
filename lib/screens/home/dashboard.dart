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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(selectedTabs: []),
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Container(
        color: Colors.white.withOpacity(0.9),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Dashboard'
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