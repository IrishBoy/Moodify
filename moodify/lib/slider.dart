import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final sliderWidth = screenWidth * 0.85; // 80% of the screen width

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              width: sliderWidth,
              child: SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 25.0,
                    pressedElevation: 0,
                    elevation: 0,
                    disabledThumbRadius: 16,
                  ),
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 5.0,
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                ),
                child: SizedBox(
                  width: sliderWidth * 0.9,
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
              ),
            ),
            Positioned(
              left: 0,
              // top: 0,
              child: Text(
                'AWFUL',
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  fontWeight:
                      FontWeight.lerp(FontWeight.w600, FontWeight.w700, 0.37),
                  fontSize: 10,
                ),
              ),
            ),
            Positioned(
              right: 0,
              // bottom: 40,
              child: Text(
                'GREAT',
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  fontWeight:
                      FontWeight.lerp(FontWeight.w600, FontWeight.w700, 0.37),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
