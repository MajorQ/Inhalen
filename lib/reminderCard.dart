import 'package:flutter/material.dart';
import 'package:inhalen/frontReminderCard.dart';
import 'package:inhalen/backReminderCard.dart';
import 'package:sliding_card/sliding_card.dart';

class ReminderCard extends StatelessWidget {
  final SlidingCardController slidingCardController;
  final Function onCardTapped;

  const ReminderCard({
    Key key,
    this.slidingCardController, @required this.onCardTapped
  }): super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTapped();
      },
      child: SlidingCard(
        slimeCardElevation: 0.5,
        cardsGap: 5.0,
        controller: slidingCardController,
        slidingCardWidth: 384.0,
        visibleCardHeight: 108.0,
        hiddenCardHeight: 90.0,
        frontCardWidget: FrontReminderCard(
            onTapped: () {
              slidingCardController.expandCard();
            },
        ),
        backCardWidget: BackReminderCard(),
      ),
    );
  }
}