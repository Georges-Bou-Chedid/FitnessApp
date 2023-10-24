import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryPieChart extends StatelessWidget {
  const SummaryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.yellow[800], // breakfast
            value: 55,
            title: 55.toStringAsFixed(0)
          ),
          PieChartSectionData(
            color: Colors.blue[900], // lunch
            value: 30,
            title: 30.toStringAsFixed(0)
          ),
          PieChartSectionData(
            color: Colors.red[800], // dinner
            value: 22,
            title: 22.toStringAsFixed(0)
          ),
          PieChartSectionData(
            color: Colors.brown[600], // snacks
            value: 10,
            title: 10.toStringAsFixed(0)
          ),
        ],
        centerSpaceRadius: 40,
        sectionsSpace: 1
      ),
      swapAnimationCurve: Curves.easeInOutQuint,
      swapAnimationDuration: const Duration(milliseconds: 2000),
    );
  }
}