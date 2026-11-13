import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/addresses_repository.dart';
import '../datasources/addresses_remote_data_source.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/create_address_request_model.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/update_address_request_model.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  final AddressesRemoteDataSource remoteDataSource;

  AddressesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AddressEntity> getAddressById(String id) {
    return remoteDataSource.getAddressById(id);
  }

  @override
  Future<List<AddressEntity>> getUserAddresses() {
    return remoteDataSource.getUserAddresses();
  }

  @override
  Future<AddressEntity> createAddress({
    required CreateAddressRequestModel request,
  }) {
    return remoteDataSource.createAddress(request: request);
  }

  @override
  Future<AddressEntity> updateAddress({
    required String id,
    required UpdateAddressRequestModel request,
  }) {
    return remoteDataSource.updateAddress(id: id, request: request);
  }

  @override
  Future<void> deleteAddress(String id) async {
    await remoteDataSource.deleteAddress(id);
  }
}
