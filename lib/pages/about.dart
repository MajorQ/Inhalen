import 'dart:ui';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    "Developers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DeveloperWidget(
                      name: "Mohammad Salman Alfarisi", imagePath: 'salman'),
                  SizedBox(height: 20.0),
                  DeveloperWidget(
                      name: "Muhammad Alfi Aldo", imagePath: 'aldo'),
                  SizedBox(height: 20.0),
                  DeveloperWidget(
                      name: "Muhammad Farhan Almasyhur", imagePath: 'farhan'),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class DeveloperWidget extends StatelessWidget {
  final String name;
  final String imagePath;

  DeveloperWidget({@required this.name, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/$imagePath.jpg"),
          radius: 80,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
              fontSize: 18.0),
        ),
      ],
    );
  }
}
