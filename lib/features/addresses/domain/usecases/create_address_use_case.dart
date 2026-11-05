import 'package:aura_maison_e_commerce/features/addresses/data/models/create_address_request_model.dart';
import '../entities/address_entity.dart';
import '../repositories/addresses_repository.dart';

class CreateAddressUseCase {
  final AddressesRepository repository;

  CreateAddressUseCase(this.repository);

  Future<AddressEntity> call({
    required CreateAddressRequestModel request,
  }) {
    return repository.createAddress(request: request);
  }
}