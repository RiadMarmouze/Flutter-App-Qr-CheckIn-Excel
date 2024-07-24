import 'package:ez_check_in/Data/data_model.dart';
import 'package:flutter/material.dart';

class DataProvider extends InheritedNotifier {
  final DataModel dataModel;

  DataProvider({
    Key? key,
    required Widget child,
    required this.dataModel,
  }) : super(
    key: key,
    child: child,
    notifier: dataModel,
  );

  static DataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProvider>()!;
  }

  @override
  bool updateShouldNotify(DataProvider oldWidget) {
    return dataModel != oldWidget.dataModel;
  }
}
