import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductItemModel {
  final String? id;
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
  final ProductModel? rawProduct;

  ProductItemModel({
    this.id,
    required this.imageUrl,
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
    required this.secondaryActionIcon,
    this.rawProduct,
  });

  factory ProductItemModel.fromProductModel(ProductModel product) {
    final catName = product.categories.isNotEmpty
        ? product.categories.first.toUpperCase()
        : 'LUXURY CREATION';

    final shortCode = product.productCode.isNotEmpty
        ? product.productCode
        : (product.id.length > 4 ? product.id.substring(0, 4) : product.id);

    return ProductItemModel(
      id: product.id,
      imageUrl: product.coverPictureUrl,
      badge1: product.discountPercentage > 0
          ? '${product.discountPercentage}% OFF'
          : 'HERITAGE NO.$shortCode',
      badge2: product.color.isNotEmpty ? product.color.toUpperCase() : 'EXCLUSIVE',
      workshop: catName,
      specsSummary: product.weight > 0 ? '${product.weight}g' : 'LIMITED RUN',
      status: product.stock > 0 ? 'AVAILABLE' : 'RESERVED',
      statusColor:
          product.stock > 0 ? AppColors.statusGreen : AppColors.goldAccent,
      category: catName,
      title: product.name,
      priceLabel: 'ACQUISITION VALUE',
      price: '${product.price.toInt()} EGP',
      description: product.description ?? '',
      specs: [
        SpecItem(
          label: 'REFERENCE',
          value: 'AUR-$shortCode',
        ),
        SpecItem(
          label: 'WEIGHT',
          value: product.weight > 0 ? '${product.weight}g' : 'Crafted Spec',
        ),
        SpecItem(
          label: 'COLOR',
          value: product.color.isNotEmpty ? product.color : 'Signature Gold',
        ),
      ],
      actionLabel: 'VIEW CREATION',
      secondaryActionIcon: Icons.calendar_month_outlined,
      rawProduct: product,
    );
  }
}

class SpecItem {
  final String label;
  final String value;
  SpecItem({required this.label, required this.value});
}
