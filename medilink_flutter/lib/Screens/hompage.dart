import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'D A S H B O A R D', 'icon': Icons.dashboard},
    {'name': 'P R O F I L E', 'icon': Icons.person},
    {'name': 'S E T T I N G S', 'icon': Icons.settings},
    {'name': 'N O T I F I C A T I O N', 'icon': Icons.notifications},
    {'name': 'H E L P', 'icon': Icons.help},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(menuItems[index]['icon']),
                  title: Text(
                    menuItems[index]['name'],
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    // Handle menu item tap
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      )),
    );
  }
}
