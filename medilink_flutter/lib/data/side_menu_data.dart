import 'package:flutter/material.dart';
import 'package:medilink_flutter/model/menu_model.dart';

class SideMenuData {
  final List<MenuModel> menu = [
    MenuModel(icon: Icons.home, title: 'Dashboard'),
    MenuModel(
      icon: Icons.person,
      title: 'Profile',
      function: () {},
    ),
    MenuModel(icon: Icons.run_circle, title: 'Exercise'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.history, title: 'History'),
    MenuModel(
      icon: Icons.logout,
      title: 'LogOut',
      function: () {},
    ),
  ];
}
