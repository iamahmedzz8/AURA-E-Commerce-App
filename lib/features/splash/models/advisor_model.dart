/// Data model representing a private assigned advisor/diplomatic liaison.
/// Edit or add advisors in `lib/data/concierge_data.dart`.
class AdvisorModel {
  final String id;
  final String name;
  final String title;
  final String salon;
  final String clearanceLevel;
  final String locations;
  final String sealText;
  final String protocolStatus;
  final String avatarInitials;

  const AdvisorModel({
    required this.id,
    required this.name,
    required this.title,
    required this.salon,
    required this.clearanceLevel,
    required this.locations,
    this.sealText = 'DIPLOMATIC SEAL',
    this.protocolStatus = 'International Security Protocol Active',
    this.avatarInitials = 'AV',
  });
}
