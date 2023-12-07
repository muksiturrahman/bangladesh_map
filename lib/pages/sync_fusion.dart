import 'package:bangla_calendar/pages/home_page.dart';
import 'package:bangladesh/bangladesh.dart';
import 'package:flutter/material.dart';

class CalendarPro extends StatefulWidget {
  const CalendarPro({super.key});

  @override
  State<CalendarPro> createState() => _CalendarProState();
}

class _CalendarProState extends State<CalendarPro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('বাংলায় ইংরেজি ক্যালেন্ডার'),
        centerTitle: true,
      ),
      body: Bangladesh(
        onTapChattogram: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },
        width: 461,
        height: 600,
        rangpurColor: Colors.orange,
        rajshahiColor: Colors.red,
        dhakaColor: Colors.indigo,
        sylhetColor: Colors.blue,
        khulnaColor: Colors.teal,
        chittagongColor: Colors.grey,
        barisalColor: Colors.pink,
        mymensinghColor: Colors.brown,
        showBorder: true,
        showName: true,
        showDivisionBorder: true,
        showDistrictBorder: true,
      ),
    );
  }
}
