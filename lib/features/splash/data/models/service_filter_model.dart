import 'package:flutter/material.dart';

/// Data model representing a filter category option.
/// Add or modify categories in `lib/data/concierge_data.dart`.
class ServiceFilterModel {
  final String id;
  final String label;
  final String categoryKey;
  final IconData? icon;

  const ServiceFilterModel({
    required this.id,
    required this.label,
    required this.categoryKey,
    this.icon,
  });
}
