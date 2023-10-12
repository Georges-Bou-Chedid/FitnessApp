import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/food.dart';
import '../../widgets/home_appbar.dart';
import '../../widgets/navdrawer.dart';

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

  @override
  Widget build(BuildContext context) {
    int totalCalories = 3000;
    int consumedCalories = 1700;
    int remainingCalories = 0;

    @override
    void initState() {
      super.initState();
      remainingCalories = totalCalories - consumedCalories;
    }

    List<PieChartSectionData> pieSections = [
      PieChartSectionData(
        color: const Color(0xff0293ee),
        value: consumedCalories.toDouble(),
        title: 'Consumed',
        radius: 1,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        showTitle: true,
        titlePositionPercentageOffset: 0.5,
      ),
      PieChartSectionData(
        color: const Color(0xfff8b250),
        value: remainingCalories.toDouble(),
        title: 'Remaining',
        radius: 1,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        showTitle: true,
        titlePositionPercentageOffset: 0.5,
      ),
    ];

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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Your Diary",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "BebasNeue",
                          color: Colors.black54,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.info,
                        ),
                        onPressed: () {

                        },
                      ),
                    ]
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                _buildMealSection('Breakfast', breakfastEntries),
                _buildMealSection('Lunch', lunchEntries),
                _buildMealSection('Dinner', dinnerEntries),
                const SizedBox(
                  height: 10.0,
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(sections: pieSections),
                  ),
                ),
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
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (entries.isEmpty)
              Center(
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
                  backgroundColor: Colors.orange // Background color
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
