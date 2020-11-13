import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      )));
}

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
