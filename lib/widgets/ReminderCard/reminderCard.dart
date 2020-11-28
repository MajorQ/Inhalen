import 'package:flutter/material.dart';
import 'frontReminderCard.dart';
import 'backReminderCard.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderCard extends StatelessWidget {

  final SlidingCardController slidingCardController;
  final List<bool> daySelection;
  final Function onCardTapped;
  final Function addLabel;
  final Function toggleDays;
  final Function delete;
  final Function onSwitchChanged;
  final Function onTimePressed;
  final String label;
  final Color cardColor;
  final bool switchStatus;
  final TimeOfDay setTime;

  const ReminderCard({
    Key key,
    this.slidingCardController,
    @required this.daySelection,
    @required this.onCardTapped, 
    @required this.addLabel,
    @required this.delete, 
    @required this.onSwitchChanged, 
    @required this.label,
    @required this.cardColor, 
    @required this.toggleDays, 
    @required this.switchStatus, 
    @required this.onTimePressed, 
    @required this.setTime, 
  }): super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTapped();
      },
      child: SlidingCard(
        slimeCardElevation: 0.5,
        cardsGap: 3.0,
        controller: slidingCardController,
        slidingCardWidth: 384.0,
        visibleCardHeight: 108.0,
        hiddenCardHeight: 95.0,
        frontCardWidget: FrontReminderCard(
          onSwitchChanged: onSwitchChanged,
          onTimePressed: onTimePressed,
          switchStatus: switchStatus,
          cardColor: cardColor, 
          label: label,
          time: setTime,
        ),
        backCardWidget: BackReminderCard(
          cardColor: cardColor,
          addLabel: addLabel,
          toggleDays: toggleDays,
          daySelection: daySelection,
          delete: delete, 
          label: label, 
        ),
      ),
    );
  }
}