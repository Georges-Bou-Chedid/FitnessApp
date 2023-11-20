import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return SingleChildScrollView(
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
                      Center(
                        child: Container(
                          width: 150,
                          child: Card(
                            elevation: 0,
                            color: const Color(0xFF3FCC7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Calories"
                                      ),
                                      Image.asset('assets/images/svg/calories.png', width: 20, height: 20)
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Center(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "${consumedCalories.toStringAsFixed(0)}\n",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "Inter",
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: 'Kcal', // Replace with your variable
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                    fontFamily: "Inter",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1, // Adjust the aspect ratio as needed
                                          child: CaloriePieChart(
                                            totalCalories: totalCalories,
                                            consumedCalories: consumedCalories,
                                          ),
                                        ),
                                      ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
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
    );
  }
}

Widget _buildMealSection(String title, List<Food> entries, Function() showAddEntryDialog) {
  return Container(
    margin: EdgeInsets.all(12.0),
    child: Card(
      elevation: 0, // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        side: const BorderSide(
          color: Color(0xFFFFFFFF), // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter"
                  ),
                ),
                const Text(
                  '0', // Replace with your number
                  style: TextStyle(
                    fontSize: 14, // Adjust the font size
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter"
                  ),
                )
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.white24, // Set the color of the line
              height: 20, // Set the height (thickness) of the line
              thickness: 2, // Set the thickness of the line
            ),
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
                    title: Text(
                      entries[index].name,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 13
                      ),
                  ),
                    subtitle: Text(
                      '${entries[index].quantity} grams',
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12
                      ),
                    ),
                    trailing: const Text(
                      '0',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 8.0),
            Center(
              // child: IconButton(
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.zero, // Remove default padding
              //     shape: const CircleBorder(), // Ensure a circular shape
              //   ),
              //   onPressed: () {
              //     showAddEntryDialog();
              //   },
              //   icon: const FaIcon(
              //     Icons.add,
              //     size: 18,
              //   ),
              // )
              child: SizedBox(
                width: 50,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF3FCC7C),
                    minimumSize: const Size(150, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: () {
                    showAddEntryDialog();
                  },
                  child: const FaIcon(
                      Icons.add,
                      size: 18,
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