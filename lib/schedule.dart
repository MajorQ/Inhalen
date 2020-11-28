import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';
import 'package:inhalen/reminder.dart';
import 'package:inhalen/reminderCard.dart';
import 'package:sliding_card/sliding_card.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  SlidingCardController controller;

  List<Reminder> reminders = [

  ];
  
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    controller = SlidingCardController();
  } 

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
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
          ),
          ReminderCard(
            slidingCardController: controller,
            onCardTapped: () {
              if (controller.isCardSeparated == true) {
                controller.collapseCard();
              }
              else {
                controller.expandCard();
              }
            }
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 104),
            child: FloatingActionButton(
              backgroundColor: CustomColors.maroon,
              foregroundColor: Colors.black,
              onPressed: () => pickTime(),
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

  pickTime() async {
    TimeOfDay _time = await showTimePicker(context: context, initialTime: time,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(), 
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          ),
        );
      });

    if(_time != null) {
      setState( () {
        time = _time;
      });
    }
  }
}
  