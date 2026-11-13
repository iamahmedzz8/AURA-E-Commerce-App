import 'package:aura_maison_e_commerce/features/addresses/data/models/create_address_request_model.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/update_address_request_model.dart';
import '../entities/address_entity.dart';

abstract class AddressesRepository {
  Future<AddressEntity> getAddressById(String id);

  Future<List<AddressEntity>> getUserAddresses();

  Future<AddressEntity> createAddress({
    required CreateAddressRequestModel request,
  });

  Future<AddressEntity> updateAddress({
    required String id,
    required UpdateAddressRequestModel request,
  });

  Future<void> deleteAddress(String id);
}
