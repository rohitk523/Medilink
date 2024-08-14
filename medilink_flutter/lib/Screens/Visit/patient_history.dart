import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medilink_flutter/util/responsive.dart';
import 'package:medilink_flutter/widgets/side_menu_widget.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientHistoryScreenState createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  List<dynamic> visitData = [];

  @override
  void initState() {
    super.initState();
    _fetchVisitData();
  }

  Future<void> _fetchVisitData() async {
    final Uri url = Uri.parse('http://localhost:8000/visits/');

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        visitData = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load visit data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: visitData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    columnWidths: const {
                      0: FixedColumnWidth(80.0),
                      1: FixedColumnWidth(80.0),
                      2: FixedColumnWidth(100.0),
                      3: FixedColumnWidth(80.0),
                      4: FixedColumnWidth(80.0),
                      5: FixedColumnWidth(150.0),
                      6: FixedColumnWidth(100.0),
                      7: FixedColumnWidth(150.0),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.blueGrey[100]),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Weight',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Height',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'BP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sugar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Symptoms',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Disease',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Prescription',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      ...visitData.map((visit) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['date'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['weight'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['height'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['BP'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['Sugar'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['Symptoms'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['Disease'] ?? 'N/A'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(visit['prescription'] ?? 'N/A'),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
