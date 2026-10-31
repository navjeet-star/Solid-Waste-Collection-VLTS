import 'package:flutter/material.dart';

/// Data model representing a dashboard module item
class ModuleItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  const ModuleItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.color,
    this.onTap,
  });
}
