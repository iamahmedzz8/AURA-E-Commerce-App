import 'package:flutter/material.dart';

/// Data model representing a bespoke concierge service item.
/// Edit or add items in `lib/data/concierge_data.dart` to change content.
class ConciergeServiceModel {
  final String id;
  final String title;
  final String tag;
  final String description;
  final String category;
  final String location;
  final IconData icon;
  final String? badge;
  final bool isAvailable;

  const ConciergeServiceModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.description,
    required this.category,
    this.location = 'Worldwide',
    this.icon = Icons.room_service_outlined,
    this.badge,
    this.isAvailable = true,
  });

  ConciergeServiceModel copyWith({
    String? id,
    String? title,
    String? tag,
    String? description,
    String? category,
    String? location,
    IconData? icon,
    String? badge,
    bool? isAvailable,
  }) {
    return ConciergeServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      icon: icon ?? this.icon,
      badge: badge ?? this.badge,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
