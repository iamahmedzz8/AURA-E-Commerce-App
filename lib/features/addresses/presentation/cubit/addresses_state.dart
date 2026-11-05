import '../../domain/entities/address_entity.dart';

abstract class AddressesState {}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressLoaded extends AddressesState {
  final AddressEntity address;

  AddressLoaded(this.address);
}

class UserAddressesLoaded extends AddressesState {
  final List<AddressEntity> addresses;

  UserAddressesLoaded(this.addresses);
}

class AddressCreated extends AddressesState {
  final AddressEntity address;

  AddressCreated(this.address);
}

class AddressesError extends AddressesState {
  final String message;

  AddressesError(this.message);
}