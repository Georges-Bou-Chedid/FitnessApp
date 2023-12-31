import 'package:fitnessapp/screens/home/diary/summary_section.dart';
import 'package:flutter/material.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/nav_drawer.dart';
import 'diary_section.dart';
import 'nutrient_section.dart';

class Diary extends StatelessWidget {
  const Diary({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
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
              SummaryPage()
            ],
          ),
        ),
    );
  }
}
