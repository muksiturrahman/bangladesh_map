import 'package:bangla_calendar/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPro extends StatefulWidget {
  const CalendarPro({Key? key}) : super(key: key);

  @override
  State<CalendarPro> createState() => _CalendarProState();
}

class _CalendarProState extends State<CalendarPro> {
  String formatBanglaDate(DateTime dateTime) {
    final formatter = DateFormat('d', 'bn_BD');
    return formatter.format(dateTime);
  }

  String formatBanglaDateForAppBar(DateTime dateTime) {
    final formatter = DateFormat('EEEE, d MMMM y', 'bn_BD');
    return formatter.format(dateTime);
  }

  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedCurrentDate = formatBanglaDateForAppBar(currentDate);

    return Localizations(
      locale: const Locale('bn'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onLongPress: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              formattedCurrentDate,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 500,
              child: SfCalendar(
                showNavigationArrow: true,
                view: CalendarView.month,
                todayHighlightColor: Colors.black,
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: 2,
                  monthCellStyle: MonthCellStyle(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  dateTextStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                appointmentTextStyle: TextStyle(
                  fontSize: 15,
                ),
                todayTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                selectionDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.purple),
                ),
                headerDateFormat: 'MMMM y',
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                showDatePickerButton: true,
                onTap: (CalendarTapDetails details) {
                  setState(() {
                    if (details.targetElement == CalendarElement.calendarCell) {
                      selectedDate = details.date!;
                    }
                  });
                },
                monthCellBuilder: (BuildContext buildContext, details) {
                  var mid = details.visibleDates.length ~/ 2.toInt();
                  var midDate = details.visibleDates[0].add(Duration(days: mid));
                  if (details.date.month != midDate.month) {
                    return Container();
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: details.date == currentDate.dateOnly() ? Colors.green : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          formatBanglaDate(details.date),
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: details.date == currentDate.dateOnly() ? Colors.white : Colors.black,),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'বাছাইকৃত তারিখ: ${formatBanglaDate(selectedDate)}, ${DateFormat('yMMMM', 'bn_BD').format(selectedDate)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime dateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}

