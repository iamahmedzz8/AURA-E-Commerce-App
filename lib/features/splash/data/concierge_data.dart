import 'package:flutter/material.dart';
import '../models/advisor_model.dart';
import '../models/concierge_service_model.dart';
import '../models/service_filter_model.dart';

/// Centralized data source for Concierge & Bespoke Services.
/// You can easily add, edit, or remove items here to update the UI.
class ConciergeData {
  /// Filter categories displayed in the interactive filter bar
  static const List<ServiceFilterModel> filterCategories = [
    ServiceFilterModel(
      id: 'f_all',
      label: 'All Services',
      categoryKey: 'all',
      icon: Icons.auto_awesome_outlined,
    ),
    ServiceFilterModel(
      id: 'f_advisors',
      label: 'Dedicated Advisors',
      categoryKey: 'advisors',
      icon: Icons.person_outline,
    ),
    ServiceFilterModel(
      id: 'f_delivery',
      label: 'Secure Delivery',
      categoryKey: 'delivery',
      icon: Icons.shield_outlined,
    ),
    ServiceFilterModel(
      id: 'f_access',
      label: 'Private Salons',
      categoryKey: 'access',
      icon: Icons.location_on_outlined,
    ),
    ServiceFilterModel(
      id: 'f_acquisitions',
      label: 'Commissions',
      categoryKey: 'acquisitions',
      icon: Icons.watch_outlined,
    ),
  ];

  /// Assigned private advisors list
  static const List<AdvisorModel> advisors = [
    AdvisorModel(
      id: 'adv_antoine',
      name: 'Antoine de Valois',
      title: 'ASSIGNED ADVISOR • VENDÔME SALON',
      salon: 'Place Vendôme, Paris',
      clearanceLevel: 'LEVEL IV',
      locations: 'PARIS / GENÈVE',
      sealText: 'DIPLOMATIC SEAL',
      protocolStatus: 'International Security Protocol Active',
      avatarInitials: 'AV',
    ),
    AdvisorModel(
      id: 'adv_helene',
      name: 'Hélène de Montmirail',
      title: 'SENIOR HOROLOGY CURATOR',
      salon: 'Genève Freeport Atelier',
      clearanceLevel: 'LEVEL V',
      locations: 'GENÈVE / ZURICH',
      sealText: 'SWISS BONDED ATELIER',
      protocolStatus: 'Cryptographic HSM Key Custodian',
      avatarInitials: 'HM',
    ),
  ];

  /// Bespoke concierge services list
  static const List<ConciergeServiceModel> services = [
    ConciergeServiceModel(
      id: 'srv_1',
      title: 'Dedicated Advisor 24/7',
      tag: 'Direct Line',
      description:
          'An exclusive encrypted channel to commission your watch acquisitions and unique pieces at any time.',
      category: 'advisors',
      location: 'Paris / Genève',
      icon: Icons.headset_mic_outlined,
      badge: '24/7 ENCRYPTED',
    ),
    ConciergeServiceModel(
      id: 'srv_2',
      title: 'Secure Personal Delivery',
      tag: 'Private Escort',
      description:
          'Armed couriers and tamper-proof seals for discreet handover at your residence or hotel suite.',
      category: 'delivery',
      location: 'Worldwide Escort',
      icon: Icons.local_shipping_outlined,
      badge: 'ARMED ESCORT',
    ),
    ConciergeServiceModel(
      id: 'srv_3',
      title: 'International Private Salon Access',
      tag: 'Worldwide',
      description:
          'Priority booking at our private salons in Paris, Zurich, New York, Tokyo and Dubaï.',
      category: 'access',
      location: 'Paris • Zurich • Tokyo • Dubaï',
      icon: Icons.meeting_room_outlined,
      badge: 'GLOBAL ACCESS',
    ),
    ConciergeServiceModel(
      id: 'srv_4',
      title: 'Confidential In-Home Viewing',
      tag: 'Bespoke Appointment',
      description:
          'Private presentation of rare complications in the discretion of your residence with an accredited gemologist.',
      category: 'advisors',
      location: 'Europe & Americas',
      icon: Icons.home_work_outlined,
      badge: 'BY APPOINTMENT',
    ),
    ConciergeServiceModel(
      id: 'srv_5',
      title: 'Bespoke Calibre Commission',
      tag: 'Haute Horlogerie',
      description:
          'Direct collaboration with our Master Watchmakers in Genève for tailor-made movements and grand complications.',
      category: 'acquisitions',
      location: 'Genève & Vallée de Joux',
      icon: Icons.precision_manufacturing_outlined,
      badge: 'PIÈCE UNIQUE',
    ),
    ConciergeServiceModel(
      id: 'srv_6',
      title: 'Vault Custody Transfer',
      tag: 'Bonded Security',
      description:
          'Seamless insured transfer between Swiss bonded vaults and Geneva free-port underwritten by Lloyd’s syndicates.',
      category: 'delivery',
      location: 'Genève Freeport',
      icon: Icons.lock_clock_outlined,
      badge: 'LLOYD’S INSURED',
    ),
  ];
}
