// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_saver.dart';
import 'slider.dart';
import 'vars.dart';
import 'package:intl/intl.dart';

class SetScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
// Array to store slider values and their timestamps

  double _currentSliderValue = 50; // Variable to store the current slider value

  void _storeValue() async {
    String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    DataModel data =
        DataModel(value: _currentSliderValue, timestamp: timestamp);

    // Use the provider to access the data and save it
    Provider.of<DataList>(context, listen: false).addData(data);

    // Clear the slider value after storing
    // setState(() {
    //   _currentSliderValue = 50;
    // });
  }

  bool _isButtonTapped = false;

  void _onButtonTap() {
    setState(() {
      _isButtonTapped = true;
      // Save the current slider value to the array
      _storeValue();
      // Add any other actions you want to perform when the button is tapped
      // printSavedValues(); // Call a function to print the array
    });

    // Remove overlay effect after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isButtonTapped = false;
      });
    });
  }

  // void printSavedValues() {
  //   // Print the array of saved values and timestamps to the console
  //   _sliderValues.forEach((data) {
  //     print(
  //         '${data.value} set at ${data.time}, length: ${_sliderValues.length}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 100),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '''HOW\nDO\nYOU\nFEEL?''',
                // textWidthBasis: 360,
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(255, 255, 255, 0.65),
                  fontWeight:
                      FontWeight.lerp(FontWeight.w600, FontWeight.w700, 0.37),
                  // textAlignCenter: TextAlignCenter,
                  letterSpacing: 32.0,
                  fontSize: 64,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
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
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circle Button with Overlay
                  Positioned(
                    top: 10,
                    child: GestureDetector(
                      onTap: _onButtonTap,
                      // onTapCancel: _resetButtonTap,
                      // onTapUp: (_) => _resetButtonTap(),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        // child: Icon(
                        //   Icons.add,
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  ),
                  // Overlay Shape
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
                  // SET Text
                  Positioned(
                    top: 150,
                    child: Text(
                      'SET',
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }
}
