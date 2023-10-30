import 'package:fitnessapp/screens/home/diary/summary_section.dart';
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
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xFF323232),
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
