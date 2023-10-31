import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../widgets/datepicker.dart';
import '../../../widgets/singlevaluefilter.dart';

class NutrientPage extends StatelessWidget {
  const NutrientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF323232),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const DatePicker(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0), // Round the corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Filter by Meal:',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Inter",
                          color: Colors.grey[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const MealFilter(
                        filterOptions: ['All', 'Breakfast', 'Lunch', 'Dinner'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[300],
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                PercentageProgressBar(label: 'Calories', percent: 50, goal: 2500, gained: 1250),
                PercentageProgressBar(label: 'Protein', percent: 30, goal: 100, gained: 30),
                PercentageProgressBar(label: 'Carbohydrates', percent: 60, goal: 100, gained: 60),
                PercentageProgressBar(label: 'Fiber', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Sugar', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Saturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Polyunsaturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Monounsaturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Trans Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Cholesterol', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Sodium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Potassium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Vitamin A', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Vitamin C', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Calcium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Iron', percent: 90, goal: 100, gained: 90),
              ],
            )
          )
        ],
      ),
    ),
  );
  }
}

class PercentageProgressBar extends StatelessWidget {
  final String label;
  final int goal;
  final int gained;
  final int percent;

  PercentageProgressBar({super.key, required this.label, required this.percent, required this.goal, required this.gained});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontFamily: "Inter",
                  ),
                ),
                Text(
                  "${gained.toStringAsFixed(0)}/${goal.toStringAsFixed(0)}g",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontFamily: "Inter",
                  ),
                )
              ],
            ),
        ),
        const SizedBox(height: 5),
        LinearPercentIndicator(
          lineHeight: 15,
          percent: percent / 100,
          center: Text('$percent%'),
          progressColor: const Color(0xFF5AC8FA),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
