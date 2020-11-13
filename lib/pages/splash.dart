import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Spacer(
              flex: 3,
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                      text: 'In',
                      style: TextStyle(
                        color: CustomColors.maroon,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0,
                      ),
                      children: [
                    TextSpan(
                        text: 'halen',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
            ),
            Spacer(
              flex: 10,
            ),
            Row(
              children: [
                SizedBox(width: 32.0),
                Image.asset('assets/images/logo_ui.png'),
                SizedBox(width: 8.0),
                Text(
                  'Disusun oleh\nTim dari Universitas Indonesia',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
