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
    // Map<DateTime, Map<int, List<double>>> groupedData = {};
    final groupedData = <DateTime, List<double>>{};
    final now = DateTime.now();

    // print("DataList: ");
    // for (var element in dataList) {
    //   print(element.value);
    //   print(element.timestamp);
    // }

    for (var entry in widget.dataList) {
      final timestamp = DateTime.parse(entry.timestamp).toLocal();
      final difference = now.difference(timestamp);

      Duration interval;
      if (difference.inMinutes < 5) {
        interval = const Duration(minutes: 5);
      }
      if (difference.inMinutes < 60) {
        interval = const Duration(minutes: 10);
      } else if (difference.inMinutes < 120) {
        interval = const Duration(minutes: 15);
      } else if (difference.inMinutes < 360) {
        interval = const Duration(minutes: 30);
      } else if (difference.inHours < 12) {
        interval = const Duration(hours: 1);
      } else if (difference.inHours < 24) {
        interval = const Duration(hours: 3);
      } else {
        interval = const Duration(hours: 4);
      }
      double hourInterval =
          interval.inHours.toDouble() == 0 ? 1 : (interval.inHours.toDouble());
      final roundedTimestamp =
          DateTime(timestamp.year, timestamp.month, timestamp.day).add(Duration(
              minutes: 60 *
                  (timestamp.minute.toDouble() ~/ (hourInterval * 60) + 1)));
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
            visibleMaximum: 80,
            visibleMinimum: -80,
            isVisible: false,
            majorGridLines: MajorGridLines(width: 0),
          ),
          series: <SplineSeries<ChartSampleData, DateTime>>[
            SplineSeries<ChartSampleData, DateTime>(
              dataSource: chartData,
              // splineType: SplineType.cardinal,
              // cardinalSplineTension: 0.8,
              xValueMapper: (ChartSampleData data, _) => data.timestamp,
              yValueMapper: (ChartSampleData data, _) => data.value,
              color: Color.fromRGBO(255, 255, 255, 0.65),
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
