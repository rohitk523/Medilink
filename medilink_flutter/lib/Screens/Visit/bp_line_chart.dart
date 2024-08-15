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
  List<FlSpot> _bpData = [];

  @override
  void initState() {
    super.initState();
    _fetchBPData();
  }

  Future<void> _fetchBPData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/dashboard/bp_data'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<FlSpot> bpData = data.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;
        double bp = double.tryParse(item['bp']) ?? 0.0;
        return FlSpot(index.toDouble(), bp);
      }).toList();

      setState(() {
        _bpData = bpData;
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
                spots: _bpData,
                isCurved: true,
                colors: [Colors.blue],
                barWidth: 3,
                belowBarData: BarAreaData(
                    show: true, colors: [Colors.blue.withOpacity(0.3)]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
