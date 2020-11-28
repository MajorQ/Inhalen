import 'package:flutter/material.dart';
import 'package:inhalen/ReminderCard/frontReminderCard.dart';
import 'package:inhalen/ReminderCard/backReminderCard.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderCard extends StatelessWidget {

  final SlidingCardController slidingCardController;
  final Function onCardTapped;
  final Function delete;
  final Function onSwitchChanged;
  final Color cardColor;
  final bool switchStatus;

  const ReminderCard({
    Key key,
    this.slidingCardController, 
    @required this.onCardTapped, 
    @required this.delete, 
    @required this.onSwitchChanged, 
    @required this.cardColor, 
    @required this.switchStatus,
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
          switchStatus: switchStatus,
          cardColor: cardColor, 
          onSwitchChanged: onSwitchChanged,
        ),
        backCardWidget: BackReminderCard(
          cardColor: cardColor, 
          delete: delete,
        ),
      ),
    );
  }
}