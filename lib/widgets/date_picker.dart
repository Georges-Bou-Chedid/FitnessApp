import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101)
    )) ?? DateTime.now();

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
          BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            border: Border.all(
              color: Colors.white54, // Set the border color here
              width: 1.0, // Set the border width here
            ),
          )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              border: Border.all(
                color: Colors.black12, // Set the border color here
                width: 1.0, // Set the border width here
              ),
          ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Transform.rotate(
                  angle: 3.141592653589793, // This is the angle in radians for 180 degrees
                  child: Image.asset('assets/images/icons/arrow-right.png', width: 15, height: 15),
                ),
                // icon: const Icon(EvaIcons.chevronLeftOutline, size: 20),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(const Duration(days: 1));
                  });
                },
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Image.asset('assets/images/icons/calendar.png', width: 20, height: 20),
                    // child: const Icon(
                    //   Icons.calendar_today,
                    //   size: 16,
                    // ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(
                      formatDate(selectedDate),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset('assets/images/icons/arrow-right.png', width: 15, height: 15),
                // icon: const Icon(EvaIcons.chevronRightOutline, size: 20),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.add(const Duration(days: 1));
                  });
                },
              ),
            ],
          )
      ),
    );
  }
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
    final formatter = DateFormat('EEE, d MMM');
    return formatter.format(date);
  }
}
