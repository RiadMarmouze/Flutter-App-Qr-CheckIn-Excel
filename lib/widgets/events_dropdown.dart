import 'package:ez_check_in/Theme/Colors.dart';
import 'package:flutter/material.dart';

class EventsDropDown extends StatefulWidget {
  const EventsDropDown({super.key});

  @override
  State<EventsDropDown> createState() => _EventsDropDownState();
}

class _EventsDropDownState extends State<EventsDropDown> {
  Map<String, DateTime> eventsDates = {
    "Date1": DateTime(2023, 12, 13),
    "Date2": DateTime(2023, 12, 14),
    "Date3": DateTime(2023, 12, 15),
  };

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DropdownButton<DateTime>(
            value: _selectedDay,
            onChanged: (newSelectedDay) {
              setState(() {
                _selectedDay = newSelectedDay;
              });
            },
            items: eventsDates.values.map((date) {
              return DropdownMenuItem<DateTime>(
                value: date,
                child: Container(
                  width: 200,
                  child: Text(
                    '${date.day}/${date.month}/${date.year}',
                  ),
                ),
              );
            }).toList(),
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.accentColor,borderRadius: BorderRadius.all(Radius.circular(15))),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
