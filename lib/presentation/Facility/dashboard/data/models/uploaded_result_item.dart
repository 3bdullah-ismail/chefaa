import 'package:flutter/material.dart';

class UploadedResultItem {
  final String name;
  final String scanType;
  final String time;
  final String status;
  final Color statusBgColor;
  final Color statusTextColor;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const UploadedResultItem({
    required this.name,
    required this.scanType,
    required this.time,
    required this.status,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}
