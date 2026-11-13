import '../entities/address_entity.dart';
import '../repositories/addresses_repository.dart';

class GetUserAddressesUseCase {
  final AddressesRepository repository;

  GetUserAddressesUseCase({required this.repository});

  Future<List<AddressEntity>> call() {
    return repository.getUserAddresses();
  }
}
