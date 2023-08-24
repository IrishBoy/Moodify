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
    // List<DataModel> dataEntries = [
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 10, hours: 3)).toString(),
    //       value: 50),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 3)).toString(),
    //       value: 25),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 6)).toString(),
    //       value: 0),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 6)).toString(),
    //       value: -50), // Yesterday
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 9)).toString(),
    //       value: -40), // Day before yesterday
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 9)).toString(),
    //       value: 25),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 9)).toString(),
    //       value: 0),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 9)).toString(),
    //       value: -1),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 1, hours: 3)).toString(),
    //       value: 50),
    //   DataModel(
    //       timestamp:
    //           DateTime.now().subtract(Duration(days: 2, hours: 3)).toString(),
    //       value: -50)
    // ];

    // dataList.addAll(dataEntries);

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
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.65), width: 5),
                  left: BorderSide(),
                  right: BorderSide(),
                  bottom: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.65), width: 5),
                )),
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
