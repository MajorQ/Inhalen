import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 55.0, 0, 0),
            child: Text('Tambahkan reminder agar Anda\ntidak lupa menggunakan obat!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 0.15,
              fontFamily: 'Raleway',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w100,
              color: Colors.black,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 104),
            child: FloatingActionButton(
              backgroundColor: CustomColors.maroon,
              foregroundColor: Colors.black,
              onPressed: () {
                // Respond to button press
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                ),
            ),
          )
        ]
      )
    );
  }
}