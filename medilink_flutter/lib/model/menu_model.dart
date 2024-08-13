import 'package:flutter/material.dart';

class MenuModel {
  final IconData icon;
  final String title;
  final VoidCallback? function; // Optional function

  const MenuModel({
    required this.icon,
    required this.title,
    this.function, // Optional parameter
  });
}
