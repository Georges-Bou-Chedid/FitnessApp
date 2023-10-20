import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../widgets/appbar.dart';
import '../../../widgets/navdrawer.dart';

class DiaryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(selectedTabs: [])
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PercentageProgressBar(label: 'Task 1', percent: 30),
            PercentageProgressBar(label: 'Task 2', percent: 60),
            PercentageProgressBar(label: 'Task 3', percent: 90),
          ],
        ),
      ),
    );
  }
}

class PercentageProgressBar extends StatelessWidget {
  final String label;
  final int percent;

  PercentageProgressBar({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        LinearPercentIndicator(
          width: 200,
          lineHeight: 20,
          percent: percent / 100,
          center: Text('$percent%'),
          progressColor: Colors.blue,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
