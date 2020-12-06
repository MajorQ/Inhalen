import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';

class BackReminderCard extends StatelessWidget {
  final List<bool> daySelection;
  final Function addLabel;
  final Function toggleDays;
  final Function delete;
  final Color cardColor;
  final String label;

  const BackReminderCard({
    Key key,
    @required this.daySelection,
    @required this.addLabel,
    @required this.toggleDays,
    @required this.delete,
    @required this.cardColor,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
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
              // borderRadius: BorderRadius.all(radius:),
              constraints: BoxConstraints(
                maxWidth: 48.0,
                maxHeight: 60.0,
              ),
              onPressed: toggleDays,
              isSelected: daySelection,
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
                label: Text('$label',
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
                label: Text('Delete',
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
