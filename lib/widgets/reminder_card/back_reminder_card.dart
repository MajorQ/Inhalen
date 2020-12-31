import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
          // Widget for reminder days
          Positioned(
            top: 10,
            child: ToggleButtons(
              children: <Widget>[
                LetterWidget(letter: 'm'),
                LetterWidget(letter: 't'),
                LetterWidget(letter: 'w'),
                LetterWidget(letter: 't'),
                LetterWidget(letter: 'f'),
                LetterWidget(letter: 's'),
                LetterWidget(letter: 's'),
              ],
              textStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              // borderRadius: BorderRadius.all(radius:),
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
              // Widget for changing reminder label
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
              // Widget for deleting reminder card
              FlatButton.icon(
                onPressed: delete,
                label: Text(
                  'delete',
                  style: TextStyle(
                    color: CustomColors.black,
                    fontFamily: 'OpenSans',
                  ),
                ).tr(),
                icon: Icon(Icons.delete, color: CustomColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LetterWidget extends StatelessWidget {
  final String letter;
  const LetterWidget({
    @required this.letter,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(letter.toUpperCase()),
    );
  }
}
