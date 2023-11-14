import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/home/dashboard.dart';

class BodyCompositionChart extends StatefulWidget {
  List<BodyCompositionData> initialChartData;
  final String title;
  final double sizedWidth;
  final Color color;

  BodyCompositionChart({Key? key, required this.initialChartData, required this.title, required this.sizedWidth, required this.color}) : super(key: key);

  @override
  _BodyCompositionChartState createState() => _BodyCompositionChartState();
}

class _BodyCompositionChartState extends State<BodyCompositionChart> {
  List<BodyCompositionData> chartData = [];
  late TextEditingController _textEditingController;
  late TextEditingController _dateController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    chartData = widget.initialChartData.toList();
    _textEditingController = TextEditingController();
    _dateController = TextEditingController();
    _selectedDate = DateTime.now();
    _updateControllerText();
  }

  void _updateControllerText() {
    _dateController.text = _selectedDate.toLocal().toString().split('.')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateControllerText();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
        _updateControllerText();
      });
    }
  }

  List<BodyCompositionData> _updateChartData(String number, String time) {
    double? parseNumberToDouble;
    parseNumberToDouble = double.tryParse(number);
    chartData.add(BodyCompositionData(formatBodyCompositionDate(_selectedDate), parseNumberToDouble!));
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
        side: BorderSide(
          color: Colors.grey[350]!, // Border color
          width: 2.0, // Border width
        ),
      ),
      color: const Color(0xFF444444),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Do you want to remove all data from the chart? This action cannot be undone.',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog on cancel
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              color: Colors.blue[800], // Set your desired text color
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              chartData.clear();
                                            });
                                            Navigator.of(context).pop(); // Close the dialog on save
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              color: Colors.blue[800], // Set your desired text color
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        );
                      },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 22,// Set your desired icon color
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                  child: Container(
                    width: 32, // Set the desired width
                    height: 32, // Set the desired height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make it circular
                      color: Colors.blue[800], // Set your desired background color
                    ),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shape: const CircleBorder(), // Ensure a circular shape
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            _selectedDate = DateTime.now();
                            _updateControllerText();

                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Add ${widget.title}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: widget.sizedWidth,
                                            child: TextFormField(
                                              controller: _textEditingController,
                                              decoration: InputDecoration(
                                                labelText: widget.title,
                                                labelStyle: const TextStyle(
                                                  fontFamily: "Inter",
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue[800]!), // Change the color as needed
                                                ),
                                                enabledBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black54), // Change the color as needed
                                                ),
                                              ),
                                              keyboardType: TextInputType.number, // Use numeric keyboard
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly // Restrict input to digits (integers)
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _dateController,
                                            decoration: InputDecoration(
                                              labelText: "Time",
                                              labelStyle: const TextStyle(
                                                fontFamily: "Inter",
                                                color: Colors.black87,
                                                fontSize: 13,
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blue[800]!), // Change the color as needed
                                              ),
                                              enabledBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.black54), // Change the color as needed
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              _selectTime(context);
                                              _selectDate(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog on cancel
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              color: Colors.blue[800], // Set your desired text color
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            switch (widget.title) {
                                              case 'Weight (Kg)':
                                                setState(() {
                                                  weightData = _updateChartData(_textEditingController.text, _dateController.text);
                                                });
                                                break;
                                              case 'Skeletal Muscle Mass (Kg)':
                                                setState(() {
                                                  skeletalMuscleData = _updateChartData(_textEditingController.text, _dateController.text);
                                                });
                                                break;
                                              case 'Percent Body Fat (%)':
                                                setState(() {
                                                  percentBodyFatData = _updateChartData(_textEditingController.text, _dateController.text);
                                                });
                                                break;

                                              default:
                                                break;
                                            }
                                            Navigator.of(context).pop(); // Close the dialog on save
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              color: Colors.blue[800], // Set your desired text color
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        );
                      },
                      child: Icon(
                        Icons.add,
                        // Replace with the calendar icon you want to use
                        color: Colors.grey[350],
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 220,
              child: SfCartesianChart(
                  title: ChartTitle(
                    text: widget.title,
                    textStyle: TextStyle(
                      fontFamily: "Inter",
                      color: Colors.grey[350],
                      fontSize: 11,
                    ),
                  ),
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                        text: 'Time',
                        textStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[350],
                          height: 2,
                        )
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey[350],
                      fontFamily: "Inter",
                    ),
                    majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                    minorGridLines: const MinorGridLines(color: Colors.grey),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(
                      color: Colors.grey[350],
                      fontFamily: "Inter",
                    ),
                    majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                    minorGridLines: const MinorGridLines(color: Colors.grey),
                  ),
                  series: <ChartSeries>[
                    // Renders spline chart
                    SplineSeries<BodyCompositionData, String>(
                      dataSource: chartData,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true, // Show data labels
                        textStyle: TextStyle(
                          color: widget.color, // Specify the desired color for data labels
                          fontSize: 10, // Specify the desired font size for data labels
                          fontFamily: "Inter", // Specify the desired font family for data labels
                          fontWeight: FontWeight.normal, // Specify the desired font weight for data labels
                        ),
                      ),
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          color: widget.color
                      ),
                      xValueMapper: (BodyCompositionData data, _) => data.date,
                      yValueMapper: (BodyCompositionData data, _) => data.value,
                      width: 3,
                      color: widget.color,
                    )
                  ]
              ),
            )
          ],
        ),
      ),
    );



  }
}


// List<WeightData> saveWeight(String newWeight, String time) {
//   double? weight;
//   weight = double.tryParse(newWeight);
//   weightData.add(WeightData(formatBodyCompositionDate(_selectedDate), weight!));
//   return weightData;
// }
//
// void saveSkeletalMuscleMass(String newSkeletalMuscleMass) {
//   print('Name saved: $newSkeletalMuscleMass');
// }
//
// void savePercentBodyFat(String newPercentBodyFat) {
//   print('Name saved: $newPercentBodyFat');
// }