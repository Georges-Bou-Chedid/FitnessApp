import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/home/dashboard.dart';

String formatDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today';
  }
  DateTime yesterday = now.subtract(Duration(days: 1));
  if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
    return 'Yesterday';
  }
  return DateFormat('MM/dd').format(date);
}

class ChartCard extends StatefulWidget {
  List<Data> initialChartData;
  final String label;
  DateTime initialStartDate;
  DateTime initialEndDate;
  final String goal;
  final Image image;

  ChartCard({super.key, required this.initialChartData, required this.label, required this.initialStartDate, required this.initialEndDate, required this.goal, required this.image});

  @override
  ChartCardState createState() => ChartCardState();
}

class ChartCardState extends State<ChartCard> {
  List<Data> chartData = []; // Create a separate chartData list
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    chartData = widget.initialChartData.toList(); // Copy the initial data
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  /// Method to update the chart data.
  List<Data> _updateChartData() {
    final daysDifference = endDate.difference(startDate).inDays;
    for (int i = 0; i < daysDifference + 1; i++) {
      chartData.add(Data(formatDate(startDate.add(Duration(days: i))), i * 100));
    }
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
                        final selectedDates = await showDateRangePicker(
                            context: context,
                            initialDateRange: DateTimeRange(
                                start: startDate, end: endDate),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            helpText: "Please select a date range of 5 days or less"
                        );

                        if (selectedDates != null) {
                          final daysDifference = selectedDates.end
                              .difference(selectedDates.start)
                              .inDays;

                          if (daysDifference <= 4) {
                            setState(() {
                              startDate = selectedDates.start;
                              endDate = selectedDates.end;
                              chartData = <Data>[];
                              chartData = _updateChartData();
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a date range of 5 days or less",
                                toastLength: Toast.LENGTH_SHORT,
                                // Toast duration (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey[200],
                                // Toast position (ToastGravity.TOP, ToastGravity.CENTER, or ToastGravity.BOTTOM)
                                timeInSecForIosWeb: 1,
                                // Time for iOS and web (in seconds)
                                fontSize: 16.0
                            );
                          }
                        }
                      },
                      child: Icon(
                        Icons.calendar_today,
                        // Replace with the calendar icon you want to use
                        color: Colors.grey[350],
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SfCartesianChart(
              title: ChartTitle(
                text: "${widget.label} Daily Report",
                textStyle: TextStyle(
                  fontFamily: "Inter",
                  color: Colors.grey[350],
                  fontSize: 12
                ),
              ),
              primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: 'Days',
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
                title: AxisTitle(
                    text: 'Consumed ${widget.label}',
                    textStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        color: Colors.grey[350],
                        fontWeight: FontWeight.w600
                    )
                ),
                labelStyle: TextStyle(
                  color: Colors.grey[350],
                  fontFamily: "Inter",
                ),
                majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                minorGridLines: const MinorGridLines(color: Colors.grey),
              ),
              series: <ColumnSeries<Data, String>>[
                ColumnSeries<Data, String>(
                    dataSource: chartData,
                    xValueMapper: (Data data, _) => data.date,
                    yValueMapper: (Data data, _) => data.value,
                    width: 0.5,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: Color(0xFF3FCC7C),
                          fontFamily: "Inter",
                        )
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color(0xFF3FCC7C),
                    animationDuration: 1000
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.image,
                const SizedBox(width: 8.0), // Adjust the spacing as needed
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Base Goal\n",
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: Colors.grey[350],
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        TextSpan(
                          text: widget.goal, // Replace with your variable
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
