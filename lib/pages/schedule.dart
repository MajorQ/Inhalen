import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'package:inhalen/widgets/reminder_card/reminder_card.dart';
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
              padding: const EdgeInsets.fromLTRB(0, 131, 0, 105),
              child: Consumer<ReminderModel>(
                builder: (context, _reminderModel, child) {
                  return ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ReminderCard(
                              key: ObjectKey(reminders[index]),
                              setTime: reminders[index].time,
                              switchStatus: reminders[index].switchON,
                              cardColor: reminders[index].cardColor,
                              label: reminders[index].label,
                              slidingCardController:
                                  reminders[index].controller,
                              daySelection: reminders[index].daySelection,
                              days: reminders[index].days,
                              onTimePressed: () =>
                                  pickTime(context, _reminderModel, index),
                              onSwitchChanged: (bool state) => _reminderModel
                                  .changeSwitchOnIndex(state, index),
                              addLabel: () =>
                                  pickLabel(context, _reminderModel, index),
                              toggleDays: (day) =>
                                  _reminderModel.toggleDays(day, index),
                              delete: () =>
                                  _reminderModel.deleteReminder(index),
                              onCardTapped: () {
                                if (reminders[index]
                                        .controller
                                        .isCardSeparated ==
                                    true) {
                                  reminders[index].controller.collapseCard();
                                } else {
                                  reminders[index].controller.expandCard();
                                  for (int i = 0; i < reminders.length; ++i) {
                                    if (i == index) {
                                      continue;
                                    } else {
                                      reminders[i].controller.collapseCard();
                                    }
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
                onPressed: () async {
                  _reminderModel.addReminder();
                  int last = reminders.length - 1;
                  var currentTime =
                      await pickTime(context, _reminderModel, last);
                  if (currentTime != null) {
                    _reminderModel.changeTimeOnIndex(last, currentTime);
                  } else {
                    _reminderModel.deleteReminder(last);
                  }
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
  Future<TimeOfDay> pickTime(
      BuildContext context, ReminderModel _reminderModel, int i) async {
    TimeOfDay _time = await showTimePicker(
        context: context,
        initialTime: _reminderModel.getTimeFromIndex(i),
        cancelText: 'Cancel',
        helpText: 'Select Time',
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: CustomColors.maroon,
                  textStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    color: CustomColors.maroon,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: CustomColors.yellow,
                dialBackgroundColor: CustomColors.lightYellow,
                dialHandColor: CustomColors.maroon,
                entryModeIconColor: CustomColors.maroon,
                hourMinuteTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: CustomColors.black,
                  fontSize: 60.0,
                ),
                helpTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                  color: CustomColors.maroon,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            ),
          );
        });

    if (_time != null) _reminderModel.changeTimeOnIndex(i, _time);

    return _time;
  }

  //function for label picker
  pickLabel(BuildContext context, ReminderModel _reminderModel, int i) async {
    showDialog(
        context: context,
        builder: (context) {
          //show text fields input
          return AlertDialog(
            backgroundColor: CustomColors.yellow,
            content: Form(
              key: labelKey,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Label',
                    focusColor: CustomColors.blue,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                    ),
                    errorStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                    )),
                maxLength: 8,
                keyboardType: TextInputType.name,
                onSaved: (String value) {
                  _reminderModel.changeLabelOnIndex(i, value);
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: CustomColors.maroon,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FlatButton(
                // textColor: CustomColors.maroon,
                onPressed: () {
                  if (labelKey.currentState.validate()) {
                    labelKey.currentState.save();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: CustomColors.maroon,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
