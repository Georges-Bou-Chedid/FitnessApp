import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
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
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            color: Color(0xFF5AC8FA), // Set your desired text color
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
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            color: Color(0xFF5AC8FA), // Set your desired text color
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
                  icon: const FaIcon(
                    Icons.clear,
                    color: Colors.red,
                    size: 16,// Set your desired icon color
                  ),
                ),
                IconButton(
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
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: widget.sizedWidth,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty ? "Required" : null,
                                          controller: _textEditingController,
                                          decoration: InputDecoration(
                                            labelText: widget.title,
                                            labelStyle: const TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 13,
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
                                        validator: (val) => val!.isEmpty ? "Required" : null,
                                        controller: _dateController,
                                        decoration: const InputDecoration(
                                          labelText: "Time",
                                          labelStyle: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 13,
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
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: Color(0xFF5AC8FA), // Set your desired text color
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (_textEditingController.text == "") {
                                          Fluttertoast.showToast(
                                              msg: "Weight is required",
                                              toastLength: Toast.LENGTH_SHORT,
                                              // Toast duration (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                                              gravity: ToastGravity.BOTTOM,
                                              // Toast position (ToastGravity.TOP, ToastGravity.CENTER, or ToastGravity.BOTTOM)
                                              timeInSecForIosWeb: 1,
                                              // Time for iOS and web (in seconds)
                                              fontSize: 16.0
                                          );

                                          return;
                                        }
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
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: Color(0xFF5AC8FA), // Set your desired text color
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
                  icon: const FaIcon(
                    Icons.add,
                    size: 21,
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
                      color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                          const Color(0xFFFFFFFF)
                          : const Color(0xFF323232),
                      fontFamily: "Inter",
                      fontSize: 11,
                    ),
                  ),
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                          const Color(0xFFFFFFFF)
                          : const Color(0xFF323232),
                      fontFamily: "Inter",
                    ),
                    majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                    minorGridLines: const MinorGridLines(color: Colors.grey),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                          const Color(0xFFFFFFFF)
                          : const Color(0xFF323232),
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