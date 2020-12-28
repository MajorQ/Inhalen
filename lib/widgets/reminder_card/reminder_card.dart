import 'package:flutter/material.dart';
import 'package:inhalen/services/reminder_data.dart';
import 'front_reminder_card.dart';
import 'back_reminder_card.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderCard extends StatelessWidget {
  final Function onCardTapped;
  final Function addLabel;
  final Function toggleDays;
  final Function delete;
  final Function onSwitchChanged;
  final Function onTimePressed;
  final ReminderData reminderObject;

  const ReminderCard(
      {Key key,
      @required this.onCardTapped,
      @required this.addLabel,
      @required this.delete,
      @required this.onSwitchChanged,
      @required this.toggleDays,
      @required this.onTimePressed,
      @required this.reminderObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTapped();
      },
      child: SlidingCard(
        slimeCardElevation: 0.5,
        cardsGap: 3.0,
        controller: reminderObject.controller,
        slidingCardWidth: 368.0,
        visibleCardHeight: 108.0,
        hiddenCardHeight: 95.0,
        frontCardWidget: FrontReminderCard(
          onSwitchChanged: onSwitchChanged,
          onTimePressed: onTimePressed,
          reminderObject: reminderObject,
        ),
        backCardWidget: BackReminderCard(
          addLabel: addLabel,
          toggleDays: toggleDays,
          delete: delete,
          reminderObject: reminderObject,
        ),
      ),
    );
  }
}
