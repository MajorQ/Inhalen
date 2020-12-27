import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/settings_model.dart';
import 'package:inhalen/widgets/inhaler_object.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Consumer<SettingsModel>(builder: (context, settingsModel, _) {
            return Text(
                (settingsModel.username != null)
                    ? 'Halo \n${settingsModel.username}!'
                    : 'loading...',
                style: TextStyle(
                  fontFamily: "Raleway",
                  color: CustomColors.maroon,
                  fontWeight: FontWeight.bold,
                  fontSize: 39,
                ));
          }),
          SizedBox(height: 24.0),
          Text(
            'Ayo kita pelajari penggunaan Inhaler!',
            style: TextStyle(
                fontFamily: "Raleway", color: Colors.black, fontSize: 20),
          ),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.center,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                InhalerCard(),
                InhalerCard(),
                InhalerCard(),
                InhalerCard(),
                InhalerCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
