class UpdateAddressRequestModel {
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String notes;

  UpdateAddressRequestModel({
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required this.phoneNumber,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'city': city,
      'street': street,
      'apartment': apartment,
      'phoneNumber': phoneNumber,
      'notes': notes,
    };
  }
}
