import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/settings_model.dart';
import 'package:inhalen/widgets/inhaler_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> inhalerJSON;

  void initState() {
    super.initState();
    _getJSON().then((value) {
      setState(() {
        inhalerJSON = value;
      });
    });
  }

  Future<List<dynamic>> _getJSON() async {
    var jsonResult;
    try {
      String jsonString =
          await rootBundle.loadString('assets/inhaler_info.json');
      jsonResult = json.decode(jsonString);
    } catch (e) {
      print('JSON File error');
    }
    return jsonResult;
  }

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
                children: (inhalerJSON != null)
                    ? [
                        InhalerCard(
                          index: 0,
                          inhalerInfo: inhalerJSON[0],
                        ),
                        InhalerCard(
                          index: 1,
                          inhalerInfo: inhalerJSON[1],
                        ),
                        InhalerCard(
                          index: 2,
                          inhalerInfo: inhalerJSON[2],
                        ),
                        InhalerCard(
                          index: 3,
                          inhalerInfo: inhalerJSON[3],
                        ),
                        InhalerCard(
                          index: 4,
                          inhalerInfo: inhalerJSON[4],
                        ),
                      ]
                    : []),
          ),
        ],
      ),
    );
  }
}
