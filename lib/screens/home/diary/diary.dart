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
            Tab(text: 'Nutrients'),
            Tab(text: 'Summary')
          ])
        ),
        drawer:  SizedBox(
            width: 250,
            child: NavDrawer()
        ),
        body: TabBarView(
          children: [
            DiaryPage(),
            NutrientPage(),
            Center(child: Text('Summary'))
          ],
        ),
        ),
    );
  }
}
