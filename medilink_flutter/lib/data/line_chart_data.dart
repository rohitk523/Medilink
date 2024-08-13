import 'package:fl_chart/fl_chart.dart';

class LineData {
  // Systolic and diastolic blood pressure data
  final systolicSpots = const [
    FlSpot(0, 120),
    FlSpot(10, 122),
    FlSpot(20, 125),
    FlSpot(30, 130),
    FlSpot(40, 128),
    FlSpot(50, 126),
    FlSpot(60, 124),
    FlSpot(70, 123),
    FlSpot(80, 127),
    FlSpot(90, 129),
    FlSpot(100, 130),
    FlSpot(110, 128),
  ];

  final diastolicSpots = const [
    FlSpot(0, 80),
    FlSpot(10, 82),
    FlSpot(20, 85),
    FlSpot(30, 87),
    FlSpot(40, 85),
    FlSpot(50, 83),
    FlSpot(60, 82),
    FlSpot(70, 81),
    FlSpot(80, 83),
    FlSpot(90, 85),
    FlSpot(100, 86),
    FlSpot(110, 84),
  ];

  final leftTitle = {
    0: '0',
    40: '40',
    80: '80',
    120: '120',
    160: '160',
  };

  final bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };
}
