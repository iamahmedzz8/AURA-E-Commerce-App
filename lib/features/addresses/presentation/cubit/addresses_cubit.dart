import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/create_address_request_model.dart';
import 'package:aura_maison_e_commerce/core/services/selected_address_service.dart';
import 'package:aura_maison_e_commerce/features/addresses/data/models/update_address_request_model.dart';
import '../../domain/usecases/update_address_use_case.dart';
import '../../domain/usecases/create_address_use_case.dart';
import '../../domain/usecases/get_address_by_id_use_case.dart';
import 'addresses_state.dart';
import '../../domain/usecases/get_user_addresses_use_case.dart';
import '../../domain/usecases/delete_address_use_case.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final GetAddressByIdUseCase getAddressByIdUseCase;
  final CreateAddressUseCase createAddressUseCase;
  final UpdateAddressUseCase updateAddressUseCase;
  final GetUserAddressesUseCase getUserAddressesUseCase;
  final SelectedAddressService selectedAddressService;
  final DeleteAddressUseCase deleteAddressUseCase;
  AddressesCubit({
    required this.getAddressByIdUseCase,
    required this.createAddressUseCase,
    required this.updateAddressUseCase,
    required this.getUserAddressesUseCase,
    required this.selectedAddressService,
    required this.deleteAddressUseCase,
  }) : super(AddressesInitial());

  Future<void> getAddressById(String id) async {
    emit(AddressesLoading());

    try {
      final address = await getAddressByIdUseCase.call(id);
      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> getUserAddresses() async {
    emit(AddressesLoading());

    try {
      final addresses = await getUserAddressesUseCase.call();
      emit(UserAddressesLoaded(addresses));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> createAddress({
    required String state,
    required String city,
    required String street,
    required String apartment,
    required String phoneNumber,
    required String notes,
  }) async {
    emit(AddressesLoading());

    try {
      final address = await createAddressUseCase.call(
        request: CreateAddressRequestModel(
          state: state,
          city: city,
          street: street,
          apartment: apartment,
          phoneNumber: phoneNumber,
          notes: notes,
        ),
      );

      // Save the ID returned from the API
      await selectedAddressService.saveAddressId(address.id);

      emit(AddressCreated(address));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> updateAddress({
    required String id,
    required String state,
    required String city,
    required String street,
    required String apartment,
    required String phoneNumber,
    required String notes,
  }) async {
    emit(AddressesLoading());

    try {
      final address = await updateAddressUseCase.call(
        id: id,
        request: UpdateAddressRequestModel(
          state: state,
          city: city,
          street: street,
          apartment: apartment,
          phoneNumber: phoneNumber,
          notes: notes,
        ),
      );

      await selectedAddressService.saveAddressId(address.id);

      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await deleteAddressUseCase.call(id);

      await getUserAddresses();
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }
}
