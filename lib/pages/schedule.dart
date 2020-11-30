import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/reminderData.dart';
import 'package:inhalen/widgets/ReminderCard/reminderCard.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  final GlobalKey<FormState> labelKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ReminderModel _reminderModel = Provider.of<ReminderModel>(context);
    List<ReminderData> reminders = _reminderModel.getList;
    return Container(
        color: Colors.white,
        child: Stack(alignment: Alignment.topCenter, children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 55.0, 0, 0),
            child: Text(
                'Tambahkan reminder agar Anda\ntidak lupa menggunakan obat!',
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
              child: Consumer<ReminderModel>(
                builder: (context, _reminderModel, child) {
                  return ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ReminderCard(
                              setTime: reminders[index].time,
                              switchStatus: reminders[index].switchON,
                              cardColor: reminders[index].cardColor,
                              label: reminders[index].label,
                              slidingCardController:
                                  reminders[index].controller,
                              daySelection: reminders[index].daySelection,
                              onTimePressed: () =>
                                  pickTime(context, _reminderModel, index),
                              onSwitchChanged: (bool state) {
                                _reminderModel.changeSwitch(state, index);
                              },
                              addLabel: () =>
                                  pickLabel(context, _reminderModel, index),
                              toggleDays: (day) {
                                _reminderModel.toggleDays(day, index);
                              },
                              delete: () {
                                _reminderModel.delete(index);
                              },
                              onCardTapped: () {
                                if (reminders[index]
                                        .controller
                                        .isCardSeparated ==
                                    true) {
                                  reminders[index].controller.collapseCard();
                                } else {
                                  for (int i = 0; i < reminders.length; ++i) {
                                    reminders[index].controller.expandCard();
                                    // if (i == index) {
                                    //   reminders[index].controller.expandCard();
                                    // }
                                    // else {
                                    //   reminders[index].controller.collapseCard();
                                    // }
                                  }
                                }
                              }),
                        );
                      });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FloatingActionButton(
                backgroundColor: CustomColors.maroon,
                foregroundColor: Colors.black,
                onPressed: () {
                  _reminderModel.add();
                  pickTime(context, _reminderModel, reminders.length - 1);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]));
  }

  // Function for time picker
  pickTime(BuildContext context, ReminderModel _reminderModel, int i) async {
    TimeOfDay _time = await showTimePicker(
        context: context,
        initialTime: _reminderModel.getTime(i),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            ),
          );
        });

    if (_time != null) {
      _reminderModel.pickTime(i, _time);
    }
  }

  pickLabel(BuildContext context, ReminderModel _reminderModel, int i) async {
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
                  _reminderModel.pickLabel(i, value);
                },
                validator: (String value) {
                  return value.length > 8
                      ? 'Label must be less than or\nequal to 8 letters'
                      : null;
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
                  if (labelKey.currentState.validate()) {
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
