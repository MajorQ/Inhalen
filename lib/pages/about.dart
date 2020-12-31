import 'dart:ui';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final PageController pageController =
      PageController(initialPage: 1, viewportFraction: 0.8);
  final List<String> name = [
    'Muhammad Salman A.',
    'Muhammad Alfi A.',
    'Muhammad Farhan A.'
  ];
  final List<String> images = ['salman', 'aldo', 'farhan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images/makaraUI.png',
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Aplikasi ini diperuntukkan kepada riset Fakultas Farmasi Universitas Indonesia",
            style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 20,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Developers",
            style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Stack(children: [
          Container(
            height: 300,
            alignment: Alignment.topCenter,
            child: PageView.builder(
              controller: pageController,
              itemCount: name.length,
              itemBuilder: (context, position) {
                return imageSlider(position);
              },
            ),
          ),
        ]),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Attribution",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            "Illustrations by Rahma Maghfira",
            style: TextStyle(fontFamily: "Raleway", fontSize: 20),
          ),
        ),
      ]),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 200,
            width: Curves.easeInOut.transform(value) * 300,
            child: widget,
          ),
        );
      },
      child: Container(
          child: DeveloperWidget(name: name[index], imagePath: images[index])),
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  final String name;
  final String imagePath;

  DeveloperWidget({@required this.name, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            // padding: EdgeInsets.only(bottom: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/$imagePath.jpg"),
              radius: 80,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
