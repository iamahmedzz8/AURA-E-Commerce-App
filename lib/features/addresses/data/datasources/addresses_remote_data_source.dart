import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/create_address_request_model.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/update_address_request_model.dart';

import '../models/address_model.dart';

abstract class AddressesRemoteDataSource {
  Future<AddressModel> getAddressById(String id);

  Future<List<AddressModel>> getUserAddresses();

  Future<AddressModel> createAddress({
    required CreateAddressRequestModel request,
  });

  Future<AddressModel> updateAddress({
    required String id,
    required UpdateAddressRequestModel request,
  });

  // Delete address
  Future<void> deleteAddress(String id);
}

class AddressesRemoteDataSourceImpl
    implements AddressesRemoteDataSource {
  final DioClient dioClient;

  AddressesRemoteDataSourceImpl({
    required this.dioClient,
  });

  @override
  Future<AddressModel> createAddress({
    required CreateAddressRequestModel request,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.addresses,
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> getAddressById(String id) async {
    final response = await dioClient.get(
      ApiEndpoints.addressById(id),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<List<AddressModel>> getUserAddresses() async {
    final response = await dioClient.get(
      ApiEndpoints.addresses,
    );

    final List<dynamic> data = response.data;

    return data
        .map((json) => AddressModel.fromJson(json))
        .toList();
  }

  @override
  Future<AddressModel> updateAddress({
    required String id,
    required UpdateAddressRequestModel request,
  }) async {
    final response = await dioClient.put(
      ApiEndpoints.addressById(id),
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<void> deleteAddress(String id) async {
    await dioClient.delete(
      ApiEndpoints.addressById(id),
    );
  }
}