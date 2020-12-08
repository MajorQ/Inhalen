import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inhalen/services/colors.dart';
import 'package:inhalen/services/reminder_model.dart';
import 'package:inhalen/pages/home.dart';
import 'package:inhalen/pages/schedule.dart';

void main() {
  runApp(ChangeNotifierProvider<ReminderModel>(
    create: (context) => ReminderModel(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => Screen(),
      },
    ),
  ));
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  // A ReminderModel instance for initialization
  ReminderModel _reminderModel;

  // Initialize ReminderModel instance then fetch list from the local storage
  void initState() {
    super.initState();
    _reminderModel = Provider.of<ReminderModel>(context, listen: false);
    _reminderModel
        .fetchListFromStorage()
        .then((value) => print('Database Initialized'));
  }

  // Change the index of bottom navigation bar based on touch
  int _currentIndex = 0;
  void _changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Function to get current page based on index
  Widget _getScaffoldBody(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SchedulePage();
    }
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: _getScaffoldBody(context),
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
