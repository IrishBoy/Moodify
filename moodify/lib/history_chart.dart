import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'vars.dart';
import 'dart:math';

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
    List<double> filteredList = [];
    double maxValue = 100;
    double minValue = -100;
    DateTime minVisibleValue =
        DateTime.now().subtract(const Duration(days: 200));
    DateTime maxVisibleValue = DateTime.now();

    for (var entry in widget.dataList) {
      final timestamp = DateTime.parse(entry.timestamp).toLocal();

      final roundedTimestamp = DateTime(
          timestamp.year, timestamp.month, timestamp.day, timestamp.hour);
      if (!groupedData.containsKey(roundedTimestamp)) {
        groupedData[roundedTimestamp] = [];
      }
      groupedData[roundedTimestamp]!.add(entry.value);
    }

    final chartData = <ChartSampleData>[];

    if (groupedData.length <= 1) {
      for (var entry in widget.dataList) {
        chartData.add(ChartSampleData(
            DateTime.parse(entry.timestamp).toLocal(), entry.value));
      }
    }

    groupedData.forEach((timestamp, values) {
      final averageValue = values.isNotEmpty
          ? values.reduce((a, b) => a + b) / values.length
          : 0.0;

      chartData.add(ChartSampleData(timestamp, averageValue));
    });
    chartData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (var value in chartData) {
      filteredList.add(value.value);
    }

    if (filteredList.isNotEmpty) {
      maxValue = filteredList.reduce(max) + 10;
      minValue = filteredList.reduce(min) - 10;
    }
    // print(filteredList);
    // print(maxValue);
    // print(minValue);
    if (chartData.isNotEmpty) {
      minVisibleValue =
          chartData.last.timestamp.subtract(const Duration(minutes: 1));
      maxVisibleValue = chartData.last.timestamp;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: SizedBox(
        width: 7 * 24 * 15,
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
          key: UniqueKey(),
          // plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            visibleMinimum: minVisibleValue,
            visibleMaximum: maxVisibleValue,
            // rangePadding : cha
            axisLine: AxisLine(
              width: 2,
              color: Color.fromRGBO(255, 255, 255, 0.64),
              dashArray: <double>[5, 5],
            ),
            // interval: 1,
            autoScrollingMode: AutoScrollingMode.start,
            majorGridLines: MajorGridLines(width: 0),
            intervalType: DateTimeIntervalType.days,
            // autoScrollingDeltaType: DateTimeIntervalType.days,
            crossesAt: 0,
            // rangePadding: ChartRangePadding.round,
            // autoScrollingMode: AutoScrollingMode.end
          ),
          primaryYAxis: NumericAxis(
            visibleMaximum: maxValue,
            visibleMinimum: minValue,
            isVisible: false,
            majorGridLines: MajorGridLines(width: 0),
            // axisLine: AxisLine(width: 2)
          ),
          series: <SplineSeries<ChartSampleData, DateTime>>[
            SplineSeries<ChartSampleData, DateTime>(
              dataSource: chartData,
              splineType: SplineType.monotonic,
              cardinalSplineTension: 0.01,
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
