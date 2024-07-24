import 'package:ez_check_in/Theme/Colors.dart';
import 'package:flutter/material.dart';

class FloatDatePicker extends StatefulWidget {
  const FloatDatePicker({super.key});

  @override
  State<FloatDatePicker> createState() => _FloatDatePickerState();
}

class _FloatDatePickerState extends State<FloatDatePicker> {

  List<DateTime> eventsDates = [
    DateTime(2023, 12, 13),
    DateTime(2023, 12, 14),
    DateTime(2023, 12, 15),
  ];

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      
      // firstDate: eventsDates.first,
      // lastDate: eventsDates.last,
      // selectableDayPredicate: (DateTime date) {
      //   return eventsDates.contains(date);
      // },
    );

    if (_picked != null) {
      setState(() {
        eventsDates.add(_picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        _selectDate();
      },
      child: const Icon(Icons.add, color: Color.fromRGBO(255, 255, 255, 1.0)),
    );
  }
}
