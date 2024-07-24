import 'package:ez_check_in/Data/data_model.dart';
import 'package:ez_check_in/Theme/Colors.dart';
import 'package:ez_check_in/providers/gsheets_provider.dart';
import 'package:ez_check_in/widgets/events_dropdown.dart';
import 'package:ez_check_in/widgets/floating_date_picker.dart';
import 'package:provider/provider.dart';

import 'package:ez_check_in/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/date_picker.dart';

class InitQRScanner extends StatelessWidget {
  const InitQRScanner({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const DatePicker(),
            const EventsDropDown(),
            Image.asset(
              "assets/images/PulseLogo.png",
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRScannerScreen(),
                  ),
                );
              },
              child: const Text(
                'Scan QR Code',
                style: TextStyle(color: AppColors.accentColor),
                
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatDatePicker()
    );
  }
}
