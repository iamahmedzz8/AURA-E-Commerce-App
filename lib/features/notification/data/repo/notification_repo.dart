import 'package:aura_maison_e_commerce/core/network_by_khaled/api_exceprions.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/api_service.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/endpoints.dart';
import 'package:aura_maison_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:dio/dio.dart';

class NotificationRepo {
  final ApiService apiService = ApiService();

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await apiService.getData(Endpoints.notifications);
      final items = response['notifications']['items'] as List;
      return items
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }
}
