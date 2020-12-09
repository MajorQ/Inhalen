import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/settings_model.dart';
import 'package:inhalen/widgets/inhaler_object.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<SettingsModel>(builder: (context, settingsModel, _) {
                    return Text(
                        (settingsModel.username != null)
                            ? 'Halo, ${settingsModel.username}'
                            : 'loading...',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: CustomColors.maroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 39,
                        ));
                  }),
                  SizedBox(height: 12.0),
                  Text(
                    'Ayo kita pelajari penggunaan Inhaler!',
                    style: TextStyle(
                        fontFamily: "Raleway",
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Pencarian",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'geser',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway'),
                    ),
                    Icon(Icons.arrow_right_sharp, size: 32.0),
                  ]),
                  SizedBox(height: 12.0),
                  Container(
                    height: 432,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 24.0,
                          childAspectRatio: 1.3),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InhalerObject();
                      },
                    ),
                  ),
                  SizedBox(height: 24.0),
                ])));
  }
}
