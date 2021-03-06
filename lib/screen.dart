import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:inhalen/pages/home.dart';
import 'package:inhalen/pages/schedule.dart';
import 'package:inhalen/pages/settings.dart';
import 'package:inhalen/services/colors.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  /// Change the index of bottom navigation bar based on touch
  int _currentIndex = 0;
  void _changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// Get current page based on index
  Widget _getScaffoldBody(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SchedulePage();
      case 2:
        return SettingsPage();
    }
    return SchedulePage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
          child: _getScaffoldBody(context)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 4.0,
              spreadRadius: 4.0,
              offset: Offset(0.0, 4.0)),
        ]),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _changeIndex,
            iconSize: 32.0,
            selectedIconTheme: IconThemeData(size: 40.0),
            selectedLabelStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.0,
                height: 1.5,
                letterSpacing: 0.4),
            unselectedLabelStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.0,
                height: 1.5,
                letterSpacing: 0.4),
            unselectedItemColor: Colors.black.withOpacity(0.38),
            selectedItemColor: CustomColors.maroon,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'bottom_navbar_icons.home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'bottom_navbar_icons.routine'.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'bottom_navbar_icons.settings'.tr(),
              ),
            ]),
      ),
    ));
  }
}
