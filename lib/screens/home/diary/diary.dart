import 'package:flutter/material.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/navdrawer.dart';
import 'diary_section.dart';
import 'nutrient_section.dart';

class Diary extends StatelessWidget {
  const Diary({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 4,
        child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: MyAppBar(selectedTabs: [
            Tab(text: 'Diary'),
            Tab(text: 'Calories'),
            Tab(text: 'Nutrients'),
            Tab(text: 'Macros'),
          ])
        ),
        drawer:  SizedBox(
            width: 250,
            child: NavDrawer()
        ),
        body: TabBarView(
          children: [
            DiaryPage(),
            Center(child: Text('Calories')),
            NutrientPage(),
            Center(child: Text('Macros')),
          ],
        ),
        ),
    );
  }
}
