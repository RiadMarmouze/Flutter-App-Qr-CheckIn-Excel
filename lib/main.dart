import 'package:ez_check_in/Data/data_model.dart';
import 'package:ez_check_in/providers/gsheets_provider.dart';
import 'package:ez_check_in/qr_scanner_screen/init_screen.dart';

import 'package:ez_check_in/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'attendees_list/attendees_list.dart';
// import 'attendees_list/attendees_list_from_json.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSheetsProvider(
            "assets/credentials.json", 
            "1HP5fgbfAeoc6MdkUOSwCJfaQEMfiU6iPo5jVb1sVoJw", 
            "Sheet1"
          )..initializeForWorksheet()
        )
      ], child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GoogleSheetsProvider>();
    return MaterialApp(
      title: 'QR Scanner Pulse Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const InitQRScanner(),
    );
  }
}
