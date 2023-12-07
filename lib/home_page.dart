import 'package:bangla_calendar/news_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  // GlobalKey for accessing context in Localizations
  final GlobalKey _calendarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    // Initialize date formatting for Bengali locale
    initializeDateFormatting('bn', null);
  }

  String _formatDateInBengali(DateTime date) {
    final bengaliNumerals = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    String convertToBengaliNumerals(int englishNumeral) {
      final englishNumerals = List<String>.generate(10, (index) => '$index');
      return englishNumeral.toString().split('').map((char) {
        final index = englishNumerals.indexOf(char);
        return index != -1 ? bengaliNumerals[index] : char;
      }).join('');
    }

    final day = convertToBengaliNumerals(date.day);
    final month = DateFormat('MMMM', 'bn').format(date);
    final year = convertToBengaliNumerals(date.year);

    return '$day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('bn', 'BD'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onLongPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
            },
              child: Text('বাংলায় ইংরেজি ক্যালেন্ডার'),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              key: _calendarKey,
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(fontSize: 20),
                formatButtonShowsNext: false,
                formatButtonVisible: false, // You can customize this based on your needs
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              locale: 'bn', // Set locale to Bengali
              calendarStyle: CalendarStyle(
                todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
                selectedTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                weekendStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              calendarBuilders: CalendarBuilders(

                // You can customize other parts of the calendar if needed
              ),
            ),
            Text(
              'আজ: ${_formatDateInBengali(_selectedDay)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
