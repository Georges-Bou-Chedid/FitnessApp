import 'package:flutter/material.dart';
import '../../../models/Food.dart';
import '../../../widgets/datepicker.dart';
import '../../../widgets/piechart.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with AutomaticKeepAliveClientMixin<DiaryPage> {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Food> breakfastEntries = [];
  List<Food> lunchEntries = [];
  List<Food> dinnerEntries = [];
  double totalCalories = 2500; // Replace with your actual values
  double consumedCalories = 1250; // Replace with your actual values

  void updateChart(double newTotalCalories, double newConsumedCalories) {
    setState(() {
      totalCalories = newTotalCalories;
      consumedCalories = newConsumedCalories;
    });
  }

  void _showAddEntryDialog() {
    setState(() {
      breakfastEntries.add(
        Food(
          name: 'Eggs',
          quantity: 100, mealTime: 'Breakfast', // Grams
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;

    return Container(
      color: Colors.white.withOpacity(0.9),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                      const Divider(
                        color: Colors.grey, // Set the color of the line
                        height: 20, // Set the height (thickness) of the line
                        thickness: 2, // Set the thickness of the line
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "Calories",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${totalCalories.toStringAsFixed(0)}\n",
                                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: '   Goal', // Replace with your variable
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered = false;
                              });
                            },
                            child: Tooltip(
                              message: 'Info',
                              child: IconButton(
                                icon: const Icon(
                                  Icons.info,
                                ),
                                onPressed: () {
                                  updateChart(2500, 1500);
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                      const Divider(
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
              _buildMealSection('Breakfast', breakfastEntries, () {
                _showAddEntryDialog();
              }),
              _buildMealSection('Lunch', lunchEntries, () {
                _showAddEntryDialog();
              }),
              _buildMealSection('Dinner', dinnerEntries, () {
                _showAddEntryDialog();
              }),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMealSection(String title, List<Food> entries, Function() showAddEntryDialog) {
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
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '0', // Replace with your number
                  style: TextStyle(
                    fontSize: 18, // Adjust the font size
                    fontWeight: FontWeight.bold, // Adjust the font weight
                    color: Colors.black, // Adjust the text color
                  ),
                )
              ],
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
                    trailing: Text('0'),
                  );
                },
              ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800] // Background color
              ),
              onPressed: () {
                showAddEntryDialog();
              },
              child: Text('Add Food'),
            ),
          ],
        ),
      ),
    ),
  );
}