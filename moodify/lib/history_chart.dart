import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'vars.dart'; // Assuming you have DataModel defined in a separate file

class HistoryChart extends StatefulWidget {
  final List<DataModel> dataList;

  HistoryChart({required this.dataList}) {
    // Sort the dataList by timestamp in ascending order
    dataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  @override
  State<HistoryChart> createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> {
  @override
  Widget build(BuildContext context) {
    final groupedData = <DateTime, List<double>>{};
    final now = DateTime.now();

    // print("DataList: ");
    // for (var element in widget.dataList) {
    //   print(element.value);
    //   print(element.timestamp);
    // }

    for (var entry in widget.dataList) {
      final timestamp = DateTime.parse(entry.timestamp).toLocal();
      // final difference = now.difference(timestamp);

      // Duration interval;
      // if (difference.inSeconds < 15) {
      //   interval = const Duration(seconds: 15);
      // } else if (difference.inSeconds < 30) {
      //   interval = const Duration(seconds: 30);
      // } else if (difference.inSeconds < 60) {
      //   interval = const Duration(seconds: 60);
      // } else if (difference.inMinutes < 2) {
      //   interval = const Duration(minutes: 2);
      // } else if (difference.inMinutes < 5) {
      //   interval = const Duration(minutes: 5);
      // } else if (difference.inMinutes < 60) {
      //   interval = const Duration(minutes: 10);
      // } else if (difference.inMinutes < 120) {
      //   interval = const Duration(minutes: 15);
      // } else if (difference.inMinutes < 360) {
      //   interval = const Duration(minutes: 30);
      // } else if (difference.inHours < 12) {
      //   interval = const Duration(hours: 1);
      // } else if (difference.inHours < 24) {
      //   interval = const Duration(hours: 3);
      // } else {
      //   interval = const Duration(hours: 4);
      // }
      // final roundedTimestamp = now.subtract(interval);

      // print(entry.timestamp, entry.value, );

      final roundedTimestamp = DateTime(
          timestamp.year, timestamp.month, timestamp.day, timestamp.hour);
      // print(roundedTimestamp);
      // print(interval.toString());
      // print(entry.timestamp.toString());
      // print(entry.value);
      if (!groupedData.containsKey(roundedTimestamp)) {
        groupedData[roundedTimestamp] = [];
      }
      groupedData[roundedTimestamp]!.add(entry.value);
    }

    final chartData = <ChartSampleData>[];

    groupedData.forEach((timestamp, values) {
      final averageValue = values.isNotEmpty
          ? values.reduce((a, b) => a + b) / values.length
          : 0.0;

      chartData.add(ChartSampleData(timestamp, averageValue));
    });
    chartData.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    // for (var element in chartData) {
    //   print(element.value);
    //   print(element.timestamp);
    // }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: SizedBox(
        width: 7 * 24 * 15,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
              axisLine: AxisLine(
                width: 2,
                color: Color.fromRGBO(255, 255, 255, 0.64),
                dashArray: <double>[5, 5],
              ),
              autoScrollingMode: AutoScrollingMode.start,
              majorGridLines: MajorGridLines(width: 0),
              intervalType: DateTimeIntervalType.days,
              autoScrollingDeltaType: DateTimeIntervalType.days,
              crossesAt: 0),
          primaryYAxis: NumericAxis(
            visibleMaximum: 100,
            visibleMinimum: -100,
            isVisible: false,
            majorGridLines: MajorGridLines(width: 0),
          ),
          series: <SplineSeries<ChartSampleData, DateTime>>[
            SplineSeries<ChartSampleData, DateTime>(
              dataSource: chartData,
              splineType: SplineType.monotonic,
              // cardinalSplineTension: 0.01  ,
              xValueMapper: (ChartSampleData data, _) => data.timestamp,
              yValueMapper: (ChartSampleData data, _) => data.value,
              color: Color.fromRGBO(255, 255, 255, 0.65),
              // markerSettings: MarkerSettings(isVisible: true)
            ),
          ],
        ),
      ),
    );
  }
}

class ChartSampleData {
  final DateTime timestamp;
  final double value;

  ChartSampleData(this.timestamp, this.value);
}
