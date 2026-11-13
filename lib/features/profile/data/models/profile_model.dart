class ProfileModel {
  final String name;
  final String initials;
  final String membership;
  final String location;
  final String advisorName;
  final String commissions;
  final String vaultHoldings;
  final String status;

  ProfileModel({
    required this.name,
    required this.initials,
    required this.membership,
    required this.location,
    required this.advisorName,
    required this.commissions,
    required this.vaultHoldings,
    required this.status,
  });

  factory ProfileModel.sample() {
    return ProfileModel(
      name: 'Baroness Victoria de Rothschild',
      initials: 'VR',
      membership: 'Privilège Circle • Tier II Member',
      location: 'Salon Place Vendôme, Paris',
      advisorName: 'Mr. Jean-Baptiste Laurent',
      commissions: '2017',
      vaultHoldings: '3 Pieces',
      status: 'Active',
    );
  }
}
