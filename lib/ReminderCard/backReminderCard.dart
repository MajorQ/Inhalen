import 'package:flutter/material.dart';

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
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          // Widget for reminder days
          Positioned(
            top: 5,
            child: ToggleButtons(
              children: <Widget>[
                ButtonTheme(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: FlatButton(
                    onPressed: () {}, 
                    child: Text ('M'),
                  ),
                ),
                ButtonTheme(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: FlatButton(
                    onPressed: () {}, 
                    child: Text ('M'),
                  ),
                ),
              ],
              textStyle: TextStyle(
                fontFamily: 'Raleway',
                fontStyle: FontStyle.normal,
              ),
              renderBorder: false,
              // constraints: BoxConstraints(
              //   maxWidth: 5,
              // ),
              onPressed: toggleDays,
              isSelected: daySelection,
            ),
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Widget for changing reminder label
              FlatButton.icon(
                onPressed: addLabel,
                label: Text('$label'),
                icon: Icon(Icons.label),
              ),
              // Widget for deleting reminder card
              FlatButton.icon(
                onPressed: delete,
                label: Text('Delete'),
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




