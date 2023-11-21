import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaloriePieChart extends StatelessWidget {
  final double totalCalories;
  final double consumedCalories;

  const CaloriePieChart({Key? key, required this.totalCalories, required this.consumedCalories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: const Color(0xFFFFFFFF),
              value: consumedCalories,
              title: "",
              radius: 10
            ),
            PieChartSectionData(
              color: Colors.white24,
              value: (totalCalories - consumedCalories),
              title: "",
              radius: 10
            ),
          ],
          sectionsSpace: 0
        ),
      swapAnimationCurve: Curves.easeInOutQuint,
      swapAnimationDuration: const Duration(milliseconds: 2000),
    );
  }
}
