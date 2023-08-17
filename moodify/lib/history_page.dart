import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'circle_average.dart';
import 'data_saver.dart';

import 'vars.dart';
import 'history_chart.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<DataModel> dataList = Provider.of<DataList>(context).dataList;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('History Screen'),
      // ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: HistoryChart(dataList: dataList),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '''YOUR\nMOOD\nLEVEL''',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.65),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 32.0,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 40),
                child: CircularOptionsWheel(
                  options: ['Today', 'Yesterday', 'Week', 'Month', 'All Time'],
                  dataList: dataList,
                  // calculateAverage(dataList), // Implement this function
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
