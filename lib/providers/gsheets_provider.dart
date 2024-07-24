import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ez_check_in/classes/attendee.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  
  late GSheets _gsheets;
  late Worksheet _worksheet;
  late Map<String, int> _sheetKeys = new Map<String, int>();

  List<Attendee> _attendees = List<Attendee>.empty();
  List<Attendee> get attendees => _attendees;

  GoogleSheetsProvider(String credentials_path, String spreadsheetId, String worksheetTitle) {
    initializeForWorksheet(
      credentials_path: credentials_path, 
      spreadsheetId: spreadsheetId, 
      worksheetTitle: worksheetTitle
    )
    .then((value) => print("worksheet initialized"))
    .catchError((onError) {
      print(onError);
    });
  }


  Future<void> initializeForWorksheet({
    String credentials_path = "assets/credentials.json", 
    String spreadsheetId = "1HP5fgbfAeoc6MdkUOSwCJfaQEMfiU6iPo5jVb1sVoJw", 
    String worksheetTitle = "Sheet1"
  }) async {

    String credentialsJson = await rootBundle.loadString(credentials_path);
    _gsheets = GSheets(jsonDecode(credentialsJson));

    final excel = await _gsheets.spreadsheet(spreadsheetId);
    _worksheet = excel.worksheetByTitle(worksheetTitle)!;

    var keys = (await _worksheet.values.row(1));
    keys.forEach((r) => this._sheetKeys[r.toLowerCase()] = keys.indexOf(r));

    await getAttendees();
  }

  Future<void> getAttendees() async {
    //print
    print(_sheetKeys);

    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    _attendees = values.map((value) => Attendee.fromSheets(value)).toList();

    notifyListeners();
  }

  Future<bool> checkInAttendee(String value, {String column = "check-in"}) async {
    //print
    print(_worksheet);

    if (_worksheet == null) {
      //print
      print("worksheet is null");

      return false;
    }

    //print
    print(_worksheet);
    // print(value == (await _worksheet.values.row(2))[0]);

    var rowIndex = await _worksheet.values.rowIndexOf(value, inColumn: 1);

    //print
    print(rowIndex);

    if (rowIndex == -1) {
      return false;
    }

    //print
    print(_sheetKeys);
    // int colIndex = 3;

    int colIndex = _sheetKeys["check-in"] as int;
    if ((await _worksheet.values.row(rowIndex))[colIndex] == "TRUE") {
      return true;
    }
    
    var result = await _worksheet.values.insertColumn(4, ["TRUE"], fromRow: rowIndex);
    notifyListeners();
    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Attendee>("attendees", attendees));
    // properties.add(ListPr('count', attendees));
  }
}
