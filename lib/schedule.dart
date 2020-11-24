import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';
import 'package:inhalen/ReminderCard/reminderCard.dart';
import 'package:sliding_card/sliding_card.dart';
import 'ReminderCard/reminderData.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  
  Color cardColor;
  SlidingCardController controller;
  ReminderData reminders = ReminderData(time: TimeOfDay.now());
  bool switchON = true;
  // List<Reminder> reminders = [ 

  // ];
 
  @override
  void initState() {
    super.initState();
    reminders.time = TimeOfDay.now();
    controller = SlidingCardController();
    cardColor = CustomColors.blue;
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack (
        alignment: Alignment.topCenter,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 131, 0, 0),
            child: ReminderCard(
              delete: () {},
              switchStatus: switchON,
              onSwitchChanged: (bool state) {
                setState(() {
                  switchON = state;

                  if (switchON == true) {
                    cardColor = CustomColors.blue;
                  }
                  else {
                    cardColor = CustomColors.lightGray;
                  }
               });
              },
              cardColor: cardColor,
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 700, 0, 0),
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

  // Function for time picker
  pickTime() async {
    TimeOfDay _time = await showTimePicker(
      context: context, 
      initialTime: reminders.time,
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
        reminders.time = _time;
      });
    }
  }
}
  