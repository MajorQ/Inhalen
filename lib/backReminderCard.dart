import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';

class BackReminderCard extends StatefulWidget {
  @override
  _BackReminderCardState createState() => _BackReminderCardState();
}

class _BackReminderCardState extends State<BackReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("This is back Card"),
        ],
      ),
    );
  }
}