import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'vars.dart'; // Assuming you have DataModel defined in a separate file

class HistoryChart extends StatelessWidget {
  final List<DataModel> dataList;

  HistoryChart({required this.dataList});

  @override
  Widget build(BuildContext context) {
    final List<ChartSampleData> chartData = dataList.map((entry) {
      return ChartSampleData(DateTime.parse(entry.timestamp), entry.value);
    }).toList();

    return SfCartesianChart(
      plotAreaBorderWidth: 0, // Hide the border around the plot area
      primaryXAxis: DateTimeAxis(
        crossesAt: 0,
        // position: AxisPosition.center, // Position the x-axis in the center
        majorGridLines: MajorGridLines(width: 0), // Hide x-axis grid lines
      ),
      primaryYAxis: NumericAxis(
        isVisible: false, // Hide the y-axis
        majorGridLines: MajorGridLines(width: 0), // Hide y-axis grid lines
      ),
      series: <LineSeries<ChartSampleData, DateTime>>[
        LineSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.timestamp,
          yValueMapper: (ChartSampleData data, _) => data.value,
          // borderWidth: 0, // Hide the border around the series
        ),
      ],
    );
  }
}

class ChartSampleData {
  final DateTime timestamp;
  final double value;

  ChartSampleData(this.timestamp, this.value);
}
