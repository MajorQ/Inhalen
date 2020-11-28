import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';
import 'package:inhalen/ReminderCard/reminderCard.dart';
import 'ReminderCard/reminderData.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  final GlobalKey<FormState> labelKey = GlobalKey<FormState>();
  List<ReminderData> reminders = [];

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
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 131, 0, 0),
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ReminderCard(
                      setTime: reminders[index].time,
                      switchStatus: reminders[index].switchON,
                      cardColor: reminders[index].cardColor,
                      label: reminders[index].label,
                      slidingCardController: reminders[index].controller,
                      daySelection: reminders[index].daySelection,
                      onTimePressed: () => pickTime(index),
                      onSwitchChanged: (bool state) {
                        setState(() {
                          reminders[index].switchON = state;

                          if (reminders[index].switchON == true) {
                            reminders[index].cardColor = CustomColors.yellow;
                          }
                          else {
                            reminders[index].cardColor = CustomColors.lightGray;
                          }
                      });
                      },
                      addLabel: () => pickLabel(index),
                      toggleDays: (day) {
                        setState(() {
                          reminders[index].daySelection[day] = !reminders[index].daySelection[day];
                        });
                      },
                      delete: () {
                        setState(() {
                          reminders.remove(reminders[index]);
                        });
                      },
                      onCardTapped: () {
                        if (reminders[index].controller.isCardSeparated == true) {
                          reminders[index].controller.collapseCard();
                        }
                        else {
                          for(int i=0; i < reminders.length; ++i) {
                            reminders[index].controller.expandCard();
                            // if (i == index) {
                            //   reminders[index].controller.expandCard();
                            // }
                            // else {
                            //   reminders[index].controller.collapseCard();
                            // }
                          }
                        }
                      }
                    ),
                  );
                }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 700, 0, 0),
            child: FloatingActionButton(
              backgroundColor: CustomColors.maroon,
              foregroundColor: Colors.black,
              onPressed: () {
                reminders.add(ReminderData(
                  time: TimeOfDay.now(),
                  label: 'label',
                  switchON: true,
                  cardColor: CustomColors.yellow,
                  daySelection: List.generate(2, (index) => false),
                ));
                pickTime(reminders.length-1);
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

  // Function for time picker
  pickTime(int i) async {
    TimeOfDay _time = await showTimePicker(
      context: context, 
      initialTime: reminders[i].time,
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
      setState( () => reminders[i].time = _time);
    }
  }

  pickLabel(int i) async {
    showDialog(
      context: context,
      builder: (context) {
        //show text fields input
        return AlertDialog(
          content: Form(
            key: labelKey,
            child: TextFormField(            
              decoration: InputDecoration(
                labelText: 'label',
                labelStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontStyle: FontStyle.normal,
                ),
                border: OutlineInputBorder(),
              ),
              maxLength: 8,
              keyboardType: TextInputType.name,
              onSaved: (String value) {
                setState( () => reminders[i].label = value);
              },
              validator: (String value) {
                return value.length > 8 ? 'Label must be less than or\nequal to 8 letters' : null;
              },
            ),
          ),
          // Button for cancel or submit label
          actions: [
            FlatButton(
              textColor: CustomColors.maroon,
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            FlatButton(
              textColor: CustomColors.maroon,
              onPressed: () {
                if(labelKey.currentState.validate()) {
                  labelKey.currentState.save();
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
    });
  }
}