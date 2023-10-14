import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/food.dart';
import '../../widgets/home_appbar.dart';
import '../../widgets/navdrawer.dart';
import '../../widgets/piechart.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<FoodEntry> breakfastEntries = [];
  List<FoodEntry> lunchEntries = [];
  List<FoodEntry> dinnerEntries = [];
  DateTime? selectedDate;
  double totalCalories = 2500; // Replace with your actual values
  double consumedCalories = 1250; // Replace with your actual values

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // Customize the date picker theme
          child: child!,
        );
      },
    )) ?? DateTime.now();

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void updateChart(double newTotalCalories, double newConsumedCalories) {
    setState(() {
      totalCalories = newTotalCalories;
      consumedCalories = newConsumedCalories;
    });
  }

  Random random = Random();
  double min = 1.0;
  double max = 2500.0;

  @override
  Widget build(BuildContext context) {
    double randomDouble = min + random.nextDouble() * (max - min);
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                      Text(
                        selectedDate != null ? formatDate(selectedDate!) : "Today",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.info,
                        ),
                        onPressed: () {
                          updateChart(2500, randomDouble);
                        },
                      ),
                    ]
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Calories Remaining",
                        style: TextStyle(
                          fontSize: 18.0,
                          // fontFamily: "BebasNeue",
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Divider(
                        color: Colors.grey, // Set the color of the line
                        height: 20, // Set the height (thickness) of the line
                        thickness: 2, // Set the thickness of the line
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 30.0),
                AspectRatio(
                  aspectRatio: 2.0, // Adjust the aspect ratio as needed
                  child: CaloriePieChart(
                    totalCalories: totalCalories,
                    consumedCalories: consumedCalories,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                _buildMealSection('Breakfast', breakfastEntries),
                _buildMealSection('Lunch', lunchEntries),
                _buildMealSection('Dinner', dinnerEntries),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildMealSection(String title, List<FoodEntry> entries) {
  return Container(
    margin: EdgeInsets.all(8.0),
    child: Card(
      elevation: 4, // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
        side: const BorderSide(
          color: Colors.grey, // Border color
          width: 2.0, // Border width
        ),
      ),
      color: const Color(0xFFC1E1C1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.grey, // Set the color of the line
              height: 20, // Set the height (thickness) of the line
              thickness: 2, // Set the thickness of the line
            ),
            const SizedBox(height: 8.0),
            if (entries.isEmpty)
              const Center(
                child: Text('No food entries yet.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(entries[index].name),
                    subtitle: Text('${entries[index].quantity} grams'),
                  );
                },
              ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800] // Background color
              ),
              onPressed: () {
                // Show a dialog to add a new food entry
                _showAddEntryDialog();
              },
              child: Text('Add Food'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper method to show a dialog for adding a new food entry
void _showAddEntryDialog() {
  // Implement your dialog here
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final tomorrow = today.add(Duration(days: 1));

  if (date.isAtSameMomentAs(today)) {
    return 'Today';
  } else if (date.isAtSameMomentAs(yesterday)) {
    return 'Yesterday';
  } else if (date.isAtSameMomentAs(tomorrow)) {
    return 'Tomorrow';
  } else {
    final formatter = DateFormat('EEEE, d MMM');
    return formatter.format(date);
  }
}
