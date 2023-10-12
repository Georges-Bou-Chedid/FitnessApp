import 'package:flutter/material.dart';
import '../../widgets/home_appbar.dart';
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
      appBar: PreferredSize(
        preferredSize: MyAppBar().preferredSize,
        child: MyAppBar(),
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Container(
        color: const Color(0xFFC1E1C1),
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
