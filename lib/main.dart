import 'package:bangla_calendar/pages/bangladesh_map.dart';
import 'package:intl/date_symbol_data_local.dart'; // Correct import statement
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bangla_calendar/pages/sf_calendar.dart';

void main() {
  initializeDateFormatting('bn', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('bn', 'BD'), // Bangla
      ],
      locale: const Locale('bn', 'BD'), // Set the initial locale to Bangla
      home: BangladeshMap(),
    );
  }
}
