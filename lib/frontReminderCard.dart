import 'package:flutter/material.dart';
import 'package:inhalen/reminder.dart';


class FrontReminderCard extends StatefulWidget {

  final Function onTapped;

  const FrontReminderCard({
    Key key,
    @required this.onTapped,
  }) : super(key: key);

  @override
  _FrontReminderCardState createState() => _FrontReminderCardState();
}

class _FrontReminderCardState extends State<FrontReminderCard> {

  bool switchON = true;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column (
            children: <Widget>[
              Text('title',
                style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 0.15,
                fontFamily: 'Raleway',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
              SizedBox(height: 5.0),
              Text('16:00',
                style: TextStyle(
                fontSize: 28.0,
                letterSpacing: 0.15,
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
              SizedBox(height: 5.0),
              Text('Wednesday',
                style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 0.15,
                fontFamily: 'Raleway',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
            ],
          ),
          Switch (
            value: switchON,
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                widget.onTapped();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}