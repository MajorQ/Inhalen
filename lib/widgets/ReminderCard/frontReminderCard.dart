import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';

class FrontReminderCard extends StatelessWidget {
  final Function onSwitchChanged;
  final Function onTimePressed;
  final bool switchStatus;
  final Color cardColor;
  final String label;
  final String days;
  final TimeOfDay time;

  const FrontReminderCard({
    Key key,
    @required this.onSwitchChanged,
    @required this.onTimePressed,
    @required this.switchStatus,
    @required this.cardColor,
    @required this.label,
    @required this.days,
    @required this.time, 
  }) : super(key: key);

  // bool switchON = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(10))),
      child: Stack(
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
                    onPressed: onTimePressed,
                    child: Text('${time.hour}:${time.minute}',
                        style: TextStyle(
                          fontSize: 40.0,
                          letterSpacing: 0.5,
                          fontFamily: 'OpenSans',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.black,
                        )),
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Days
                    Text('$days',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 0.15,
                          fontFamily: 'Raleway',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.black,
                        )),
                    //separator
                    Text(label == 'Label'? '':' \u2022 ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.black,
                      ),
                    ),
                    Text(label == 'Label'? '':'$label',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 0.15,
                          fontFamily: 'Raleway',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.black,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 294,
            child: Switch(
              value: switchStatus,
              onChanged: onSwitchChanged,
            ),
          ),
        ],
      ),
    );
  }
}
