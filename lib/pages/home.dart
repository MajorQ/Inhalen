import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:inhalen/services/settings_model.dart';
import 'package:inhalen/widgets/inhaler_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _inhalerJSON;

  @override
  void didChangeDependencies() {
    _fetchJSON(context).then((result) {
      setState(() {
        _inhalerJSON = result;
      });
    });
    super.didChangeDependencies();
  }

  Future<List<dynamic>> _fetchJSON(BuildContext context) async {
    var jsonResult;
    try {
      String jsonString = (context.locale == Locale('id'))
          ? await DefaultAssetBundle.of(context)
              .loadString('assets/inhaler_info-ID.json')
          : await DefaultAssetBundle.of(context)
              .loadString('assets/inhaler_info-EN.json');
      jsonResult = json.decode(jsonString);
    } catch (e) {
      print('JSON File error -> $e');
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
            return (settingsModel.username != null)
                ? Text('hello', style: Theme.of(context).textTheme.headline4)
                    .tr(args: [settingsModel.username])
                : Text('loading', style: Theme.of(context).textTheme.headline4)
                    .tr();
          }),
          SizedBox(height: 24.0),
          Text('learn', style: Theme.of(context).textTheme.subtitle1).tr(),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.center,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: (_inhalerJSON != null)
                    ? [
                        InhalerCard(
                          index: 0,
                          inhalerInfo: _inhalerJSON[0],
                        ),
                        InhalerCard(
                          index: 1,
                          inhalerInfo: _inhalerJSON[1],
                        ),
                        InhalerCard(
                          index: 2,
                          inhalerInfo: _inhalerJSON[2],
                        ),
                        InhalerCard(
                          index: 3,
                          inhalerInfo: _inhalerJSON[3],
                        ),
                        InhalerCard(
                          index: 4,
                          inhalerInfo: _inhalerJSON[4],
                        ),
                      ]
                    : []),
          ),
        ],
      ),
    );
  }
}
