import 'package:flutter/material.dart';
import '../../../models/Food.dart';
import '../../../widgets/datepicker.dart';
import '../../../widgets/diarypiechart.dart';

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
    super.build(context);
    bool isHovered = false;

    return Container(
      color: const Color(0xFF323232),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Calories Remaining",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Inter",
                                color: Colors.grey[300],
                                fontWeight: FontWeight.bold
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
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.grey[300],
                                ),
                                onPressed: () {
                                  updateChart(2500, 2200);
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                      Divider(
                        color: Colors.grey[300], // Set the color of the line
                        height: 20, // Set the height (thickness) of the line
                        thickness: 2, // Set the thickness of the line
                      ),
                    ]
                ),
              ),
              Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          color: const Color(0xFF3FCC7C),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Consumed',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
              const SizedBox(height: 30.0),
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${totalCalories.toStringAsFixed(0)}\n",
                            style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const TextSpan(
                            text: 'Goal', // Replace with your variable
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12, fontWeight:
                              FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 2.0, // Adjust the aspect ratio as needed
                    child: CaloriePieChart(
                      totalCalories: totalCalories,
                      consumedCalories: consumedCalories,
                    ),
                  ),
                ]
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
              _buildMealSection('Snacks', dinnerEntries, () {
                _showAddEntryDialog();
              }),
              _buildMealSection('Exercise', dinnerEntries, () {
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
        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
        side: BorderSide(
          color: Colors.grey[300]!, // Border color
          width: 2.0, // Border width
        ),
      ),
      color: Colors.grey[300],
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter"
                  ),
                ),
                const Text(
                  '0', // Replace with your number
                  style: TextStyle(
                    fontSize: 15, // Adjust the font size
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter"
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
                child: Text(
                  'No food entries yet.',
                  style: TextStyle(
                    fontFamily: "Inter"
                  ),
                ),
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
            const SizedBox(height: 8.0),
            Center(
              child: SizedBox(
                width: 150, // Adjust the width as needed
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF3FCC7C),
                    minimumSize: const Size(150, 36), // Set the minimum button size
                  ),
                  onPressed: () {
                    showAddEntryDialog();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}