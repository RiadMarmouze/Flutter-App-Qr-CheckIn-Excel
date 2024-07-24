import 'package:ez_check_in/Theme/Colors.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _dateController = TextEditingController();

  List<DateTime> availableDates = [
    DateTime(2023, 12, 13),
    DateTime(2023, 12, 14),
    DateTime(2023, 12, 15),
    // Add more dates as needed
  ];

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: availableDates.first,
      lastDate: availableDates.last,
      selectableDayPredicate: (DateTime date) {
        return availableDates.contains(date);
      },
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'DATE',
          filled: true,
          labelStyle: TextStyle(color: AppColors.textColor,fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.calendar_today,color: AppColors.primaryColor,),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
        ),
        readOnly: true,
        onTap: () {
          _selectDate();
        },
      ),
    );
  }
}
