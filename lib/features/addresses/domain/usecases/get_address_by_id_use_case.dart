import '../entities/address_entity.dart';
import '../repositories/addresses_repository.dart';

class GetAddressByIdUseCase {
  final AddressesRepository repository;

  GetAddressByIdUseCase(this.repository);

  Future<AddressEntity> call(String id) {
    return repository.getAddressById(id);
  }
}
