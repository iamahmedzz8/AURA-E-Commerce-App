
class ContactModel {
  final String imagePath;
  final String salonCategory;
  final String salonName;
  final String address;
  final String hoursLabel;
  final String hoursValue;
  final String phoneLabel;
  final String phone;
  final String emailLabel;
  final String email;
  final String? vaultExpertise;
  final String? accreditation;

  ContactModel({
    required this.imagePath,
    required this.salonCategory,
    required this.salonName,
    required this.address,
    required this.hoursLabel,
    required this.hoursValue,
    required this.phoneLabel,
    required this.phone,
    required this.emailLabel,
    required this.email,
    this.vaultExpertise,
    this.accreditation,
  });

  // Sample data for the Paris salon.
  factory ContactModel.paris() {
    return ContactModel(
      imagePath: 'assets/images/building.png',
      salonCategory: 'PARIS • PREMIER SALON',
      salonName: 'Hôtel d’Évreux',
      address: '12 Place Vendôme, 75001 Paris, France',
      hoursLabel: 'HOURS / TIME ZONE',
      hoursValue: '10:00 — 19:30 CET',
      phoneLabel: 'SECURE LINE',
      phone: '+33 1 42 68 00 00',
      emailLabel: 'ENCRYPTED EMAIL',
      email: 'vendome@auramaison.com',
    );
  }

  // Sample data for the Geneva salon.
  factory ContactModel.geneva() {
    return ContactModel(
      imagePath: 'assets/images/freeport&meryrin.png',
      salonCategory: 'GENÈVE • WORKSHOPS & STORAGE',
      salonName: 'Meyrin Workshops',
      address: 'Chemin du Grand-Puits 38, 1217 Meyrin, Switzerland',
      hoursLabel: 'HOURS / TIME ZONE',
      hoursValue: 'By confirmed appointment',
      phoneLabel: 'SWISS LINE',
      phone: '+41 22 819 00 00',
      emailLabel: 'MANAGEMENT EMAIL',
      email: 'geneve@auramaison.com',
      vaultExpertise: 'Diplomatic Protocol',
      accreditation: 'Approval within 24h',
    );
  }
}
