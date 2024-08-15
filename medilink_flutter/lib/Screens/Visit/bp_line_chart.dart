import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BPChartScreen extends StatefulWidget {
  const BPChartScreen({Key? key}) : super(key: key);

  @override
  _BPChartScreenState createState() => _BPChartScreenState();
}

class _BPChartScreenState extends State<BPChartScreen> {
  List<FlSpot> _systolicData = [];
  List<FlSpot> _diastolicData = [];

  @override
  void initState() {
    super.initState();
    _fetchBPData();
  }

  Future<void> _fetchBPData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/bp_data'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<FlSpot> systolicData = [];
      List<FlSpot> diastolicData = [];

      for (int i = 0; i < data.length; i++) {
        final bp = data[i]['bp'].split('/');
        if (bp.length == 2) {
          double systolic = double.tryParse(bp[0]) ?? 0.0;
          double diastolic = double.tryParse(bp[1]) ?? 0.0;

          systolicData.add(FlSpot(i.toDouble(), systolic));
          diastolicData.add(FlSpot(i.toDouble(), diastolic));
        }
      }

      setState(() {
        _systolicData = systolicData;
        _diastolicData = diastolicData;
      });
    } else {
      // Handle the error
      print('Failed to load BP data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BP Line Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: _systolicData,
                isCurved: true,
                color: Colors.red,
                barWidth: 3,
                belowBarData:
                    BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: _diastolicData,
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(
                    show: true, color: Colors.blue.withOpacity(0.3)),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
