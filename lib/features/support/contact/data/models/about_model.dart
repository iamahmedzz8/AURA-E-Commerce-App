import 'package:flutter/material.dart';

class AboutModel {
  final String pillarNumber;
  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;

  const AboutModel({
    required this.pillarNumber,
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
  });
}
