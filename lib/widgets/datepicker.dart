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
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.0),
        color: Colors.grey[300], // Set the indicator color to white
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Color(0xFF323232), size: 17),
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
                    child: const Icon(
                      Icons.calendar_today, // Replace with the calendar icon you want to use
                      color: Color(0xFF323232),
                      size: 17,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(
                      formatDate(selectedDate),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Color(0xFF323232), size: 17),
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
  // final formatter = DateFormat('EEEE, d MMM');
  // return formatter.format(date);
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
