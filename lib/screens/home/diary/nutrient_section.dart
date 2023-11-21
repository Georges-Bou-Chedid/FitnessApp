import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/meal_filter.dart';

class NutrientPage extends StatelessWidget {
  const NutrientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xFFFFFFFF), // Set the border color here
                          width: 0.5, // Set the border width here
                        ),
                      )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: const Color(0xFF323232), // Set the border color here
                            width: 0.5, // Set the border width here
                          ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Filter by Meal:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      MealFilter(
                        filterOptions: ['All', 'Breakfast', 'Lunch', 'Dinner'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  "${gained.toStringAsFixed(0)}/${goal.toStringAsFixed(0)}g",
                  style: const TextStyle(
                    fontSize: 12.0,
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
          center: Text(
            '$percent%',
            style: const TextStyle(
              fontFamily: "Inter"
            ),
          ),
          progressColor: const Color(0xFF5AC8FA),
          barRadius: const Radius.circular(15)
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
