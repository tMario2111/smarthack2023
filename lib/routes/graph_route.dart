import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class GraphRoute extends StatefulWidget {
  const GraphRoute({
    super.key,
    required this.ratings,
  });

  final Map<String, List<int>> ratings;

  @override
  State<StatefulWidget> createState() => _GraphRouteState();
}

class _GraphRouteState extends State<GraphRoute> {
  final data = <LineChartBarData>[];

  void _setupPoints() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.pink
    ];
    var k = 0;
    widget.ratings.forEach((key, value) {
      final list = <FlSpot>[];
      var j = 0;
      for (var i in value) {
        list.add(FlSpot(j as double, i as double));
        j++;
      }
      data.add(LineChartBarData(
        spots: list,
        isCurved: true,
        color: colors[k],
        preventCurveOverShooting: true,
      ));
      k++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupPoints();
    return Scaffold(
      body: Center(
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: 10,
            lineBarsData: data,
          ),
        ),
      ),
    );
  }
}
