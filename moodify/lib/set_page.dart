// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'data_saver.dart';
import 'slider.dart';
import 'vars.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'sql_connector.dart';

var uuid = Uuid();

class SetScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SetScreenState createState() => _SetScreenState();

  // dbHelper.initializeDatabase();
}

class _SetScreenState extends State<SetScreen> with TickerProviderStateMixin {
  final dbHelper = DatabaseHelper(); // Create an instance of the DatabaseHelper
// Array to store slider values and their timestamps

  double _currentSliderValue = 0; // Variable to store the current slider value

  void _storeValue() async {
    String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    String uuid = Uuid().v1();
    DataModel data =
        DataModel(id: uuid, value: _currentSliderValue, timestamp: timestamp);

    // Use the provider to access the data and save it
    dbHelper.insertDataModel(data);

    // Provider.of<DataList>(context, listen: false).addData(data);

    // Clear the slider value after storing
    // setState(() {
    //   _currentSliderValue = 50;
    // });
  }

  bool _isButtonTapped = false;
  // ignore: unused_field
  Future<void>? _delayedFuture;

  void _onButtonTap() {
    setState(() {
      _isButtonTapped = true;
      _storeValue();
    });

    // Call the delayed callback after a second
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isButtonTapped = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _delayedFuture = Future.value(); // Initialize the Future
  }

  @override
  void dispose() {
    _delayedFuture = Future.value(); // Cancel the Future
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.4,
                  child: Text(
                    '''how\ndo\nyou\nfeel?'''.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.65),
                      fontWeight: FontWeight.lerp(
                          FontWeight.w600, FontWeight.w700, 0.37),
                      letterSpacing: 32.0,
                      fontSize: 60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.2,
                  child: Container(
                    alignment: Alignment.center,
                    child: SliderBlock(
                      sliderValue: _currentSliderValue,
                      onChanged: (newValue) {
                        setState(() {
                          _currentSliderValue =
                              newValue; // Update the current slider value
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 10,
                          child: GestureDetector(
                            onTap: _onButtonTap,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                        ),
                        if (_isButtonTapped)
                          Positioned(
                            top: 5,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 130,
                          child: Text(
                            'SET',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                )
                              ],
                              color: Color.fromRGBO(217, 217, 217, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 64,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
