import 'package:charts_flutter/flutter.dart' as chart;

class TimeResponse {
  final String notif;
  final int range;
  final chart.Color color;

  TimeResponse({required this.notif,required this.range,required this.color});
}