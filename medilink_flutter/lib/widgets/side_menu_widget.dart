import 'package:flutter/material.dart';
import 'package:medilink_flutter/const/constant.dart';
import 'package:medilink_flutter/data/side_menu_data.dart';
import 'package:medilink_flutter/model/menu_model.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF171821),
      child: ListView(
        children: data.menu.asMap().entries.map((entry) {
          final index = entry.key;
          final menuItem = entry.value;
          return buildMenuEntry(menuItem, index, context);
        }).toList(),
      ),
    );
  }

  Widget buildMenuEntry(MenuModel menuItem, int index, BuildContext context) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          // Call the function if it is provided
          menuItem.function?.call();

          // Special case for LogOut: perform navigation to login page
          if (menuItem.title == 'LogOut') {
            Navigator.pushNamed(context, '/login');
          } else if (menuItem.title == 'Profile') {
            Navigator.pushNamed(context, '/profile');
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                menuItem.icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              menuItem.title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
