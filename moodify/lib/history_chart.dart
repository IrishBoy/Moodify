import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'vars.dart'; // Assuming you have DataModel defined in a separate file

class HistoryChart extends StatelessWidget {
  final List<DataModel> dataList;

  HistoryChart({required this.dataList}) {
    // Sort the dataList by timestamp in ascending order
    dataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartSampleData> chartDataDetailed = dataList.map((entry) {
      return ChartSampleData(DateTime.parse(entry.timestamp), entry.value);
    }).toList();

    DateTime initialVisibleMinimum;
    DateTime initialVisibleMaximum;
    if (chartDataDetailed.isNotEmpty) {
      initialVisibleMinimum = chartDataDetailed
          .first.timestamp; // Show data from the first timestamp
      initialVisibleMaximum = chartDataDetailed.last.timestamp;
    } else {
      initialVisibleMaximum = DateTime.now();
      initialVisibleMinimum =
          DateTime.now().subtract(Duration(days: 7)); // Default to 7 days ago
    }
    final Map<DateTime, Map<int, List<double>>> groupedData = {};

    for (var entry in dataList) {
      final timestamp = DateTime.parse(entry.timestamp).toLocal();
      final dateHourKey = DateTime(
          timestamp.year, timestamp.month, timestamp.day, timestamp.hour);
      final value = entry.value;

      if (groupedData.containsKey(dateHourKey)) {
        if (groupedData[dateHourKey]!.containsKey(timestamp.hour)) {
          groupedData[dateHourKey]![timestamp.hour]!.add(value);
        } else {
          groupedData[dateHourKey]![timestamp.hour] = [value];
        }
      } else {
        groupedData[dateHourKey] = {
          timestamp.hour: [value]
        };
      }
    }

    // Calculate average values for each date and hour
    final List<ChartSampleData> chartData = [];
    groupedData.forEach((dateHourKey, hourValues) {
      final averageValue = hourValues.entries
              .map((entry) =>
                  entry.value.reduce((a, b) => a + b) / entry.value.length)
              .reduce((a, b) => a + b) /
          hourValues.length;

      chartData.add(ChartSampleData(dateHourKey, averageValue));
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // physics: scrollphysics(),
      child: Container(
        width: 7 * 24 * 15,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
              axisLine: AxisLine(
                width: 2,
                color: Color.fromRGBO(255, 255, 255, 0.64),
                dashArray: <double>[5, 5],
              ),
              // borderColor:
              autoScrollingMode: AutoScrollingMode.end,
              visibleMaximum: initialVisibleMaximum,
              visibleMinimum: initialVisibleMinimum,
              majorGridLines: MajorGridLines(width: 0),
              // autoScrollingDelta: 7,
              intervalType: DateTimeIntervalType.days,
              autoScrollingDeltaType: DateTimeIntervalType.days,
              crossesAt: 0),
          primaryYAxis: NumericAxis(
            visibleMaximum: 60,
            visibleMinimum: -60,
            isVisible: false,
            majorGridLines: MajorGridLines(width: 0),
          ),
          series: <SplineSeries<ChartSampleData, DateTime>>[
            SplineSeries<ChartSampleData, DateTime>(
              dataSource: chartData,
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
