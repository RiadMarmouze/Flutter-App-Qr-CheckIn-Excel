import 'package:flutter/foundation.dart';

class DataModel extends ChangeNotifier {
  List<DateTime> _dateList = [];
  DateTime _selectedDate = DateTime.now();

  List<DateTime> get dateList => _dateList;
  DateTime get selectedDate => _selectedDate;

  void addDate(DateTime newDate) {
    _dateList.add(newDate);
    notifyListeners();
  }

  void removeDate(DateTime dateToRemove) {
    _dateList.remove(dateToRemove);
    notifyListeners();
  }

  void selectDate(int index) {
    _selectedDate = _dateList[index];
    notifyListeners();
  }
}
