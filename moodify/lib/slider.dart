import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            min: -50.0,
            max: 50.0,
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
