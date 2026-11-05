import 'package:dio/dio.dart';
import 'package:aura_maison_e_commerce/features/admin/inventory/domain/entities/inventory_item.dart';

abstract class InventoryRemoteDataSource {
  Future<List<InventoryItem>> fetchInventoryItems();
}

class InventoryApiDataSource implements InventoryRemoteDataSource {
  final Dio dio = Dio();
  final String baseUrl = 'https://accessories-eshop.runasp.net/api/products';

  @override
  Future<List<InventoryItem>> fetchInventoryItems() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List items = data['items'];

        return items.map((item) => InventoryItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    }
  }
}

class MockInventoryRemoteDataSource implements InventoryRemoteDataSource {
  @override
  Future<List<InventoryItem>> fetchInventoryItems() async {
    return [];
  }
}