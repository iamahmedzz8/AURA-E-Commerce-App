class AddressEntity {
  final String id;
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String notes;

  const AddressEntity({
    required this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required this.phoneNumber,
    required this.notes,
  });
}
