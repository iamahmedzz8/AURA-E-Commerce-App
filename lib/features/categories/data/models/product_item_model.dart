import 'package:flutter/material.dart';

class ProductItemModel {
  final String imageUrl;
  final String badge1;
  final String badge2;
  final String workshop;
  final String specsSummary;
  final String status;
  final Color statusColor;
  final String category;
  final String title;
  final String priceLabel;
  final String price;
  final String description;
  final List<SpecItem> specs;
  final String actionLabel;
  final IconData secondaryActionIcon;

  ProductItemModel(
      {required this.imageUrl,
      required this.badge1,
      required this.badge2,
      required this.workshop,
      required this.specsSummary,
      required this.status,
      required this.statusColor,
      required this.category,
      required this.title,
      required this.priceLabel,
      required this.price,
      required this.description,
      required this.specs,
      required this.actionLabel,
      required this.secondaryActionIcon});
}

class SpecItem {
  final String label;
  final String value;
  SpecItem({required this.label, required this.value});
}
