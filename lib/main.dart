import 'package:flutter/material.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/pages/home.dart';
import 'package:inhalen/pages/schedule.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(ChangeNotifierProvider<ReminderModel>(
    create: (context) => ReminderModel(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => ResponsiveWrapper.builder(
              Screen(),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(350, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
            ),
      },
    ),
  ));
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  // Bottom navigation bar control
  int _currentIndex = 0;
  void _changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Function to get current Page
  Widget _getBody(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return Consumer<ReminderModel>(
            builder: (context, _reminderModel, child) => SchedulePage());
    }
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: _getBody(context),
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Belajar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'Rutinitas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help),
                label: 'Bantuan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ]),
      ),
    ));
  }
}
