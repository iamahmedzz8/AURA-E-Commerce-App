import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/support/support/data/models/police_privacy.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/widgets/police_item.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final List<PrivacySectionModel> privacySections = const [
    PrivacySectionModel(
      number: '01',
      title: 'Limited Collection & Acquisition Data',
      details: 'Detailed audit protocols and strict data collection limits applied during high-value watchmaking acquisitions and private viewings.',
    ),
    PrivacySectionModel(
      number: '02',
      title: 'End-to-End Encryption & Digital Escrow',
      details: 'All communications and asset transactions are secured using military-grade digital escrow systems and hardware-backed keys.',
    ),
    PrivacySectionModel(
      number: '03',
      title: 'Biometric Data & Hardware Enclave',
      details: 'Biometric records (FaceID/TouchID) are stored locally inside secure device enclaves and never transmitted to external cloud servers.',
    ),
    PrivacySectionModel(
      number: '04',
      title: 'Patron Rights & Complete Deletion',
      details: 'Patrons hold the absolute right to request complete data scrubbing and cryptographic wiping of their portfolio history upon session termination.',
    ),
    PrivacySectionModel(
      number: '05',
      title: 'Cross-Border Transfers & Swiss Customs',
      details: 'Compliance protocols regarding international transport of masterpieces under Swiss customs exemptions and diplomatic seals.',
    ),
    PrivacySectionModel(
      number: '06',
      title: 'Heritage Protection Officer',
      details: 'Direct channel access to our appointed European Data Protection and Heritage Compliance Officer for confidential inquiries.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Workshop Settings',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: const [
              Icon(Icons.circle, color: AppColors.primaryGold, size: 6),
              SizedBox(width: 6),
              Text(
                'AUDITED VERSION 2025 • VENDÔME NOTARY’S OFFICE',
                style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Privacy Seal &\nPatron Data Protection',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Absolute discretion protocol compliant with Swiss and European heritage preservation standards (GDPR & FADP).',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          const PrivacyConfidentialityCard(),
          const SizedBox(height: 16),
          ...privacySections.map((section) => PrivacyExpansionTileCard(section: section)),
          const SizedBox(height: 8),
          const RegulatoryNoticeCard(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.background,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, size: 16, color: AppColors.background),
                  SizedBox(width: 8),
                  Text(
                    'DOWNLOAD FULL PROTOCOL (SEALED PDF)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, color: Colors.green, size: 6),
              SizedBox(width: 6),
              Text(
                'Verified SHA-256 Certificate • Digital Notarized Seal',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}