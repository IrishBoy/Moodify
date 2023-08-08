import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_saver.dart';
import 'history_page.dart';
import 'set_page.dart';
import 'vars.dart';

void main() {
  runApp(MoodifyApp());
}

class MoodifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataList>(
      create: (_) =>
          DataList()..loadData(), // Initialize the provider and load data
      child: MaterialApp(
        title: 'Slider App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
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

  List<Widget> _pages = [
    SetScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      Provider.of<DataList>(context, listen: false).loadData();
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.65),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Color.fromRGBO(255, 255, 255, 1),
            selectedItemColor: Color.fromRGBO(217, 217, 217, 1),
            // onTap: (index) {
            //   if (index == 1) {
            //     // Manually load data when navigating to the History screen
            //     Provider.of<DataList>(context, listen: false).loadData();
            //   }
            //   // Change the screen according to the navigation bar
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             index == 0 ? SetScreen() : HistoryScreen()),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
