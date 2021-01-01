import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'package:easy_localization/easy_localization.dart';

class FrontReminderCard extends StatelessWidget {
  final Function onSwitchChanged;
  final Function onTimePressed;
  final ReminderData reminderObject;

  const FrontReminderCard(
      {Key key,
      @required this.onSwitchChanged,
      @required this.onTimePressed,
      @required this.reminderObject})
      : super(key: key);

  // bool switchON = true;

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = reminderObject.time;
    return Card(
      color: reminderObject.cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(5))),
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
                    child: Text(
                        time.hour < 10 && time.minute < 10
                            ? '0${time.hour}:0${time.minute}'
                            : time.hour < 10
                                ? '0${time.hour}:${time.minute}'
                                : time.minute < 10
                                    ? '${time.hour}:0${time.minute}'
                                    : '${time.hour}:${time.minute}',
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
                    Text(
                        reminderObject.getDays(
                            dayList: [
                              'mon'.tr(),
                              'tue'.tr(),
                              'wed'.tr(),
                              'thu'.tr(),
                              'fri'.tr(),
                              'sat'.tr(),
                              'sun'.tr()
                            ],
                            emptyMsg: 'select_day'.tr(),
                            weekdayMsg: 'weekday'.tr(),
                            weekendMsg: 'weekend'.tr(),
                            fullMsg: 'every_day'.tr()),
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 0.15,
                          fontFamily: 'Raleway',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.black,
                        )),
                    //separator
                    Text(
                      reminderObject.label == 'Label' ? '' : ' \u2022 ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.black,
                      ),
                    ),
                    Text(
                        reminderObject.label == 'Label'
                            ? ''
                            : '${reminderObject.label}',
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
            left: 280,
            child: Switch(
              activeColor: CustomColors.blue,
              value: reminderObject.isEnabled,
              onChanged: onSwitchChanged,
            ),
          ),
        ],
      ),
    );
  }
}
