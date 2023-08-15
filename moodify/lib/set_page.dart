// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class _SetScreenState extends State<SetScreen> with TickerProviderStateMixin {
// Array to store slider values and their timestamps

  double _currentSliderValue = 0; // Variable to store the current slider value

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
  Future<void>? _delayedFuture;

  late Ticker _ticker;

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
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '''HOW\nDO\nYOU\nFEEL?''',
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
                      // onTapUp: _onTapUp,
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
