import 'package:bangla_calendar/pages/sf_calendar.dart';
import 'package:bangla_calendar/widgets/dialog.dart';
import 'package:bangladesh/bangladesh.dart';
import 'package:flutter/material.dart';

class BangladeshMap extends StatefulWidget {
  const BangladeshMap({super.key});

  @override
  State<BangladeshMap> createState() => _BangladeshMapState();
}

class _BangladeshMapState extends State<BangladeshMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('বাংলাদেশের মানচিত্র',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Bangladesh(
        onTapChattogram: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarPro()));
        },
        onTapDhaka: (){
          ReUsableDialog.show(context, 'Dhaka');
        },
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        rangpurColor: Colors.orange,
        rajshahiColor: Colors.red,
        dhakaColor: Colors.indigo,
        sylhetColor: Colors.blue,
        khulnaColor: Colors.teal,
        chittagongColor: Colors.grey,
        barisalColor: Colors.pink,
        mymensinghColor: Colors.brown,
        nameTextStyle: TextStyle(fontSize: 20,color: Colors.white),
        showBorder: true,
        showName: true,
        showDivisionBorder: true,
        showDistrictBorder: true,
      ),
    );
  }
}
