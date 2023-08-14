import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'data_saver.dart';
import 'set_page.dart';

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
    List<DataModel> dataEntries = [
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 1)).toString(),
          value: 25),
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 1)).toString(),
          value: -25),
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 1)).toString(),
          value: 25),
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 1)).toString(),
          value: -25), // Yesterday
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 2)).toString(),
          value: 25), // Day before yesterday
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 7)).toString(),
          value: 25),
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 10)).toString(),
          value: 0),
      DataModel(
          timestamp: DateTime.now().subtract(Duration(days: 30)).toString(),
          value: -50),
    ];

    dataList.addAll(dataEntries);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('History Screen'),
      // ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 7,
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
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final value = dataList[index].value;
                    final timestamp = dataList[index].timestamp;
                    return ListTile(
                      title: Text(
                        'Value: $value',
                        style: TextStyle(
                            color: Colors.white), // Set the font color to white
                      ),
                      subtitle: Text(
                        'Timestamp: $timestamp',
                        style: TextStyle(
                            color: Colors.white), // Set the font color to white
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
