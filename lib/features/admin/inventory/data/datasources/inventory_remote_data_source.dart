import 'package:aura_maison_e_commerce/features/admin/inventory/domain/entities/inventory_entity.dart';
import 'package:flutter/material.dart';


abstract class InventoryRemoteDataSource {
  Future<List<InventoryItem>> fetchInventoryItems();
}

class MockInventoryRemoteDataSource implements InventoryRemoteDataSource {
  @override
  Future<List<InventoryItem>> fetchInventoryItems() async {
    await Future.delayed( Duration(milliseconds: 100));

    return [
      const InventoryItem(
        imageUrl: 'https://picsum.photos/seed/watch/200/200',
        brand: 'HIGH COMPLICATION',
        status: 'IN SALON',
        statusColor: Colors.greenAccent,
        title: 'Royal Tourbillon Squelette',
        reference: '#TF-8860-2',
        unitInfo: '2 units',
        categoryLabel: 'CATALOGUE VALUE',
        price: '142 000 €',
        showSalonButton: true,
      ),
      const InventoryItem(
        imageUrl: 'https://picsum.photos/seed/trunk/200/200',
        brand: 'WORKSHOP LEATHER GOODS',
        status: 'IN PRODUCTION',
        statusColor: Colors.blueAccent,
        title: 'Alligator Leather Watch Trunk',
        reference: '#WW-ALL-01',
        unitInfo: '1 unit',
        categoryLabel: 'CATALOGUE VALUE',
        price: '47 800 €',
      ),
      const InventoryItem(
        imageUrl: 'https://picsum.photos/seed/ring/200/200',
        brand: 'FINE WATCHMAKING',
        status: 'SOLD OUT',
        statusColor: Colors.redAccent,
        title: 'Imperial Chronograph in Rose Gold',
        reference: '#CI-714-AU',
        unitInfo: 'Allocation Closed',
        categoryLabel: 'LAST PRICE',
        price: '96 500 €',
        isRestock: true,
      ),
      const InventoryItem(
        imageUrl: 'https://picsum.photos/seed/diamond/200/200',
        brand: 'HIGH JEWELRY',
        status: '1 OF A KIND',
        statusColor: Colors.amber,
        title: 'Evolk Diamond Solitaire 4.2ct',
        reference: '#HJ-SOL-042',
        unitInfo: '1 unit',
        categoryLabel: 'GIA ESTIMATE',
        price: '215 000 €',
        isAssign: true,
      ),
    ];
  }
}
