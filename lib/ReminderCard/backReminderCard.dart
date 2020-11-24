import 'package:flutter/material.dart';

class BackReminderCard extends StatelessWidget {

  final String label;
  final Function delete;
  final Color cardColor;

  const BackReminderCard({
    Key key, 
    this.label, 
    @required this.delete, 
    @required this.cardColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          // Widget for reminder days
          // Row(
          //   children: <Widget>[
          //    SizedBox(height: 10),
          //   ],
          // ),
          Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Widget for changing reminder label
              FlatButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      //show text fields input
                      return AlertDialog(
                        // title: Text('Reset settings?'),
                        content: TextFormField(
                          // initialValue: 'Reminder',
                          decoration: InputDecoration(
                            labelText: label,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        // Button for cancel or 
                        actions: [
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {},
                            child: Text('Cancel'),
                          ),
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {},
                            child: Text('OK'),
                          ),
                        ],
                      );
                  });
                },
                label: Text('Label'),
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




