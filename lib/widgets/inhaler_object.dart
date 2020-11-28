import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';

class InhalerObject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
            color: CustomColors.yellow,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ]),
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/respiclick.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 160,
                height: 48,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  'Nama Inhaler',
                  style: TextStyle(fontSize: 20, fontFamily: "Raleway"),
                ),
              ),
            )
          ],
        ));
  }
}
