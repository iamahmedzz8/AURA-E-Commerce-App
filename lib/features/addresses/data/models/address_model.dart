import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.state,
    required super.city,
    required super.street,
    required super.apartment,
    required super.phoneNumber,
    required super.notes,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      apartment: json['apartment'] as String,
      phoneNumber: json['phoneNumber'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'city': city,
      'street': street,
      'apartment': apartment,
      'phoneNumber': phoneNumber,
      'notes': notes,
    };
  }
}