import 'dart:math';
import 'package:flutter/material.dart';
import 'vars.dart';

// ignore: must_be_immutable
class CircularOptionsWheel extends StatefulWidget {
  final List<String> options;
  List<DataModel> dataList;

  CircularOptionsWheel({required this.options, required this.dataList});

  @override
  // ignore: library_private_types_in_public_api
  _CircularOptionsWheelState createState() => _CircularOptionsWheelState();
}

class _CircularOptionsWheelState extends State<CircularOptionsWheel> {
  double rotationAngle = 0.0;
  int selectedOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(widget.options[selectedOptionIndex]);
        setState(() {
          selectedOptionIndex =
              (selectedOptionIndex + 1) % widget.options.length;
          rotationAngle = selectedOptionIndex.toDouble();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < widget.options.length; i++)
            Positioned.fill(
              child: Transform.rotate(
                angle: 2 * pi * (i / widget.options.length - rotationAngle),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Transform.rotate(
                      angle: -2 * pi * (i / widget.options.length),
                      child: Text(
                        widget.options[i],
                        style: TextStyle(
                          color: Colors.white.withOpacity(
                              i == selectedOptionIndex ? 1.0 : 0.5),
                          fontSize: i == selectedOptionIndex ? 18 : 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Container(
            width: 135,
            height: 135,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 0, 0, 1),
                // border: Border.all(
                //     color: Color.fromRGBO(217, 217, 217, 0.65), width: 8),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(217, 217, 217, 0.65),
                      // offset: Offset(20.0, 20.0),
                      blurRadius: 20.0,
                      spreadRadius: 30.0)
                ]),
            alignment: Alignment.center,
            child: Text(
              calculateAverage(
                widget.dataList,
                widget.options[selectedOptionIndex],
              ).toStringAsFixed(2),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double calculateAverage(List<DataModel> dataList, String period) {
  DateTime now = DateTime.now();
  DateTime startDateTime;
  double average;

  switch (period) {
    case 'Today':
      startDateTime = DateTime(now.year, now.month, now.day);
      break;
    case 'Yesterday':
      startDateTime = DateTime(now.year, now.month, now.day - 1);
      break;
    case 'Week':
      startDateTime = DateTime(now.year, now.month, now.day - now.weekday + 1);
      break;
    case 'Month':
      startDateTime = DateTime(now.year, now.month);
      break;
    case 'All Time':
    default:
      dataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      startDateTime = DateTime.parse(dataList.first.timestamp);
  }

  List<DataModel> filteredList = dataList
      .where((data) => DateTime.parse(data.timestamp).isAfter(startDateTime))
      .toList();

  if (filteredList.isEmpty) {
    average = 0.0;
  } else {
    double sum = filteredList.map((data) => data.value).reduce((a, b) => a + b);
    average = sum / filteredList.length;
  }
  return average;
}
