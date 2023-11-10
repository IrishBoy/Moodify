import 'package:flutter/material.dart';

import 'history_page.dart';
import 'set_page.dart';
import 'info_page.dart';
import 'sql_connector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper(); // Create an instance of the DatabaseHelper
  await dbHelper.initializeDatabase();
  runApp(MoodifyApp());
}

class MoodifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbHelper =
        DatabaseHelper(); // Create an instance of the DatabaseHelper
    dbHelper.initializeDatabase(); // Initialize the database

    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [SetScreen(), HistoryScreen(), InfoScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.1,
      color: Color.fromRGBO(0, 0, 0, 100),
      child: Scaffold(
        extendBody: true,
        body: _pages[_selectedIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset('icons/set_inactive.png'),
                  activeIcon: Image.asset('icons/set_active.png'),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset('icons/history_inactive.png'),
                  activeIcon: Image.asset('icons/history_active.png'),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset('icons/info_inactive.png'),
                  activeIcon: Image.asset('icons/info_active.png'),
                  label: '')
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.65),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Color.fromRGBO(255, 255, 255, 1),
            selectedItemColor: Color.fromRGBO(217, 217, 217, 1),
          ),
        ),
      ),
    );
  }
}
