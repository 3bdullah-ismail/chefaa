import 'package:flutter/material.dart';

class PendingUploadItem {
  final String? id;
  final String name;
  final String scanType;
  final String initials;
  final Color avatarBgColor;
  final Color avatarTextColor;
  bool isUploading;

  PendingUploadItem({
    this.id,
    required this.name,
    required this.scanType,
    required this.initials,
    required this.avatarBgColor,
    required this.avatarTextColor,
    this.isUploading = false,
  });
}
