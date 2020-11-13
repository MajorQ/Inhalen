import 'package:flutter/material.dart';
import 'package:inhalen/colors.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Screen()));
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          iconSize: 32.0,
          selectedFontSize: 16.0,
          unselectedFontSize: 14.0,
          selectedItemColor: CustomColors.maroon,
          unselectedItemColor: CustomColors.light_gray,
          showUnselectedLabels: true,
          elevation: 24.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text('Belajar')),
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm), title: Text('Rutinitas')),
            BottomNavigationBarItem(
                icon: Icon(Icons.help), title: Text('Bantuan')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Pengaturan')),
          ]),
    ));
  }
}
