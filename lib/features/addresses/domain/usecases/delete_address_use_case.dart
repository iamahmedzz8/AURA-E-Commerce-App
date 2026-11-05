import '../repositories/addresses_repository.dart';

class DeleteAddressUseCase {
  final AddressesRepository repository;

  DeleteAddressUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteAddress(id);
  }
}