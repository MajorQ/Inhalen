import 'package:flutter/material.dart';

class FrontReminderCard extends StatelessWidget {

  final Color cardColor;
  final Function onSwitchChanged;
  final bool switchStatus;

  const FrontReminderCard({
    Key key, 
    @required this.cardColor, 
    @required this.onSwitchChanged,
    @required this.switchStatus,
  }) : super(key: key);

  // bool switchON = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Stack (
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned(
            left: 22.33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ButtonTheme(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   child: FlatButton(
                    onPressed: () {},
                    child: Text('16:00',
                      style: TextStyle(
                      fontSize: 40.0,
                      letterSpacing: 0.5,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )),
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Days
                    Text('Wednesday',
                      style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 0.15,
                      fontFamily: 'Raleway',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
                    //seperator
                    Text(' \u2022 ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 
                      ),
                    ),
                    Text('title',
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
              ],
            ),
          ),
          Positioned(
            left: 294,
            child: Switch (
              value: switchStatus,
              onChanged: onSwitchChanged,
            ),
          ),
        ],
      ),
    );
  }
}



