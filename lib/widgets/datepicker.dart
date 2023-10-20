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
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(const Duration(days: 1));
                  });
                },
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Text(
                  formatDate(selectedDate),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.add(const Duration(days: 1));
                  });
                },
              ),
            ]
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  final formatter = DateFormat('EEEE, d MMM');
  return formatter.format(date);
  // final now = DateTime.now();
  // final today = DateTime(now.year, now.month, now.day);
  // final yesterday = today.subtract(Duration(days: 1));
  // final tomorrow = today.add(Duration(days: 1));
  //
  // if (date.isAtSameMomentAs(today)) {
  //   return 'Today';
  // } else if (date.isAtSameMomentAs(yesterday)) {
  //   return 'Yesterday';
  // } else if (date.isAtSameMomentAs(tomorrow)) {
  //   return 'Tomorrow';
  // } else {
  //   final formatter = DateFormat('EEEE, d MMM');
  //   return formatter.format(date);
  // }
}
