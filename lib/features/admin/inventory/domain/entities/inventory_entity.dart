import 'package:flutter/material.dart';

class InventoryItem {
  final String imageUrl;
  final String brand;
  final String status;
  final Color statusColor;
  final String title;
  final String reference;
  final String unitInfo;
  final String categoryLabel;
  final String price;
  final bool showSalonButton;
  final bool isRestock;
  final bool isAssign;

  const InventoryItem({
    required this.imageUrl,
    required this.brand,
    required this.status,
    required this.statusColor,
    required this.title,
    required this.reference,
    required this.unitInfo,
    required this.categoryLabel,
    required this.price,
    this.showSalonButton = false,
    this.isRestock = false,
    this.isAssign = false,
  });
}
