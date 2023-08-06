import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MoodifyApp());
}

class SliderData {
  final double value;
  final DateTime time;

  SliderData({required this.value, required this.time});
}

class MoodifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  List<Widget> _pages = [
    PageOne(),
    PageTwo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
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
          ),
        ),
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<SliderData> _sliderValues =
      []; // Array to store slider values and their timestamps

  double _currentSliderValue =
      0.5; // Variable to store the current slider value

  @override
  void initState() {
    super.initState();
    _loadSavedValues(); // Load previously saved slider values from shared preferences
  }

  void _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? sliderDataList = prefs.getStringList('slider_values');
    if (sliderDataList != null) {
      _sliderValues = sliderDataList.map((data) {
        List<String> values = data.split(';');
        double value = double.parse(values[0]);
        DateTime time =
            DateTime.fromMillisecondsSinceEpoch(int.parse(values[1]));
        return SliderData(value: value, time: time);
      }).toList();
    }
  }

  void _saveSliderValue() async {
    setState(() {
      // Create a SliderData instance with the current slider value and current timestamp
      SliderData sliderData =
          SliderData(value: _currentSliderValue, time: DateTime.now());
      _sliderValues.add(sliderData); // Add the SliderData instance to the array
      _saveToSharedPreferences(); // Save the array to shared preferences
    });
  }

  void _saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sliderDataList = _sliderValues.map((data) {
      return '${data.value};${data.time.millisecondsSinceEpoch}';
    }).toList();
    prefs.setStringList('slider_values', sliderDataList);
  }

  bool _isButtonTapped = false;

  void _onButtonTap() {
    setState(() {
      _isButtonTapped = true;
      // Save the current slider value to the array
      _saveSliderValue();
      // Add any other actions you want to perform when the button is tapped
      printSavedValues(); // Call a function to print the array
    });

    // Remove overlay effect after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isButtonTapped = false;
      });
    });
  }

  void printSavedValues() {
    // Print the array of saved values and timestamps to the console
    _sliderValues.forEach((data) {
      print(
          '${data.value} set at ${data.time}, length: ${_sliderValues.length}');
    });
  }

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

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 100),
      child: Column(
        // columnBackgroundColor: Color.fromRGBO(0, 0, 0, 100),
        children: [
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Text('Block 1'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '''YOUR\nMOOD\nLEVEL''',
                // textWidthBasis: 360,
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(255, 255, 255, 0.65),
                  fontWeight:
                      FontWeight.lerp(FontWeight.w600, FontWeight.w700, 0.37),
                  // textAlignCenter: TextAlignCenter,
                  letterSpacing: 32.0,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Text('Block 3'),
            ),
          ),
        ],
      ),
    );
  }
}

class SliderBlock extends StatefulWidget {
  final double sliderValue;
  final ValueChanged<double> onChanged;

  SliderBlock({required this.sliderValue, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _SliderBlockState createState() => _SliderBlockState();
}

class _SliderBlockState extends State<SliderBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 16.0,
                pressedElevation: 0,
                elevation: 0,
                disabledThumbRadius: 16),
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 5.0,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
          ),
          child: Slider(
            value: widget.sliderValue,
            onChanged: widget.onChanged,
            thumbColor: Color.fromRGBO(217, 217, 217, 1),
            activeColor: Color.fromRGBO(255, 255, 255, 0.65),
            inactiveColor: Color.fromRGBO(255, 255, 255, 0.65),
            min: 0.0,
            max: 100.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AWFUL',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'GREAT',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
