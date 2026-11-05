import '../repositories/addresses_repository.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/update_address_request_model.dart';
import '../entities/address_entity.dart';

class UpdateAddressUseCase {
  final AddressesRepository repository;

  UpdateAddressUseCase(this.repository);

  Future<AddressEntity> call({
    required String id,
    required UpdateAddressRequestModel request,
  }) {
    return repository.updateAddress(
      id: id,
      request: request,
    );
  }
}