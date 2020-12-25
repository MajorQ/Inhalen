import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_data.dart';

class BackReminderCard extends StatelessWidget {
  final Function addLabel;
  final Function toggleDays;
  final Function delete;
  final ReminderData reminderObject;

  const BackReminderCard({
    Key key,
    @required this.addLabel,
    @required this.toggleDays,
    @required this.delete,
    @required this.reminderObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: reminderObject.cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(10))),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          // Reminder days selection toggle buttons
          Positioned(
            top: 10,
            child: ToggleButtons(
              children: <Widget>[
                Text('   M   '),
                Text('   T   '),
                Text('   W   '),
                Text('   T   '),
                Text('   F   '),
                Text('   S   '),
                Text('   S   '),
              ],
              textStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              constraints: BoxConstraints(
                maxWidth: 48.0,
                maxHeight: 60.0,
              ),
              onPressed: toggleDays,
              isSelected: reminderObject.daySelection,
              borderRadius: BorderRadius.circular(30),
              borderColor: CustomColors.black,
              borderWidth: 1.5,
              selectedBorderColor: CustomColors.black,
              selectedColor: CustomColors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Button for changing the reminder card label
              FlatButton.icon(
                onPressed: addLabel,
                label: Text(
                  '${reminderObject.label}',
                  style: TextStyle(
                    color: CustomColors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
                icon: Icon(Icons.label, color: CustomColors.black),
              ),
              // Button to delete a reminder card
              FlatButton.icon(
                onPressed: delete,
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: CustomColors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
                icon: Icon(Icons.delete, color: CustomColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
