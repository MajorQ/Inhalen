import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/widgets/reminder_card/reminder_card.dart';

class SchedulePage extends StatelessWidget {
  final GlobalKey<FormState> _labelKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var reminderModel = Provider.of<ReminderModel>(context);
    return Container(
      color: Colors.white,
      child: Stack(alignment: Alignment.topCenter, children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 55.0, 0, 0),
          child: Text('add_reminder',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1)
              .tr(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 131, 0, 105),
          child: ListView.builder(
              itemCount: reminderModel.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ReminderCard(
                      key: ObjectKey(reminderModel.list[index]),
                      reminderObject: reminderModel.list[index],
                      onTimePressed: () async {
                        TimeOfDay time = await pickTime(
                            context, reminderModel.getTimeFrom(index));
                        reminderModel.changeTimeAt(index, time);
                      },
                      onSwitchChanged: (bool state) {
                        reminderModel.changeStateAt(state, index);
                      },
                      addLabel: () async {
                        String label = await pickLabel(
                            context, reminderModel.getLabelFrom(index));
                        reminderModel.changeLabelAt(index, label);
                      },
                      toggleDays: (day) {
                        reminderModel.toggleDaysAt(day, index);
                      },
                      delete: () {
                        reminderModel.delete(index);
                      },
                      onCardTapped: () {
                        reminderModel.tapCardAt(index);
                      }),
                );
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              backgroundColor: CustomColors.maroon,
              foregroundColor: Colors.black,
              onPressed: () async {
                TimeOfDay time = await pickTime(context, TimeOfDay.now());
                reminderModel.add(time);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]),
    );
  }

  /// Function to show time picker and change [time] on a [ReminderData] object
  // TODO: make these functions callable from anywhere and clean up
  Future<TimeOfDay> pickTime(
      BuildContext context, TimeOfDay initialTime) async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: initialTime,
        cancelText: 'cancel'.tr(),
        helpText: 'select_time'.tr(),
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
    return time;
  }

  /// Function to change [label] on a [ReminderData] object
  Future<String> pickLabel(BuildContext context, String initialText) async {
    String label;
    await showDialog(
        context: context,
        builder: (context) {
          /// Show text fields input
          return AlertDialog(
            backgroundColor: CustomColors.yellow,
            content: Form(
              key: _labelKey,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'label_input'.tr(),
                    focusColor: CustomColors.blue,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                    ),
                    errorStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
                maxLength: 8,
                keyboardType: TextInputType.name,
                onSaved: (String value) => label = value,
                validator: (String value) {
                  return value.length > 8 ? 'label_input_validator'.tr() : null;
                },
              ),
            ),

            /// Button to cancel or submit label
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'cancel'.tr(),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: CustomColors.maroon,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (_labelKey.currentState.validate()) {
                    _labelKey.currentState.save();
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
    return label;
  }
}
