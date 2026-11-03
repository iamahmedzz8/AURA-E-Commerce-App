import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/support/contact/data/models/about_model.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/widgets/about_as_widget.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/screens/police_privacy.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  final List<AboutModel> pillars = const [
    AboutModel(
      pillarNumber: 'PILLAR 01',
      title: 'Mechanical Excellence',
      description:
          'Fully numbered in-house calibres, variable-inertia balances and hand-assembled perpetual complications. Each movement embodies half a century of sovereign chronometric research.',
      tags: ['PRIVATE EDITIONS', 'CHRONOMETRIC PRECISION'],
      icon: Icons.precision_manufacturing,
    ),
    AboutModel(
      pillarNumber: 'PILLAR 02',
      title: 'The Sanctuary Vault',
      description:
          'Secure custody in high-security Swiss free zones and level X certified vaults. Climate controlled to a tenth of a degree for lasting biometric and mechanical preservation.',
      tags: ['SWISS FREE ZONE', 'INERT ATMOSPHERE'],
      icon: Icons.lock_outline,
    ),
    AboutModel(
      pillarNumber: 'PILLAR 03',
      title: 'The Private Concierge',
      description:
          'Personalized handover protocol with armored escort in a diplomatic convoy, supported by an assigned curator watching 24/7 over your watch collection and heritage assets.',
      tags: ['DIPLOMATIC ESCORT', 'DEDICATED CURATOR'],
      icon: Icons.security,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: 'Workshop Settings'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: const [
              Icon(Icons.circle, color: AppColors.primaryGold, size: 6),
              SizedBox(width: 6),
              Text(
                'HOUSE FOUNDED IN 1912',
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
            'House of Fine\nWatchmaking & Private\nJewelry',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'The Alliance of Eternal Time and Sovereign Security',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 24),
          const ChapterHeader(
            chapter: 'Chapter I',
            title: 'The Workshop’s Foundations',
          ),
          const SizedBox(height: 16),
          const ArtisanCard(),
          const SizedBox(height: 16),
          const QuoteCard(),
          const SizedBox(height: 28),
          const ChapterHeader(
            chapter: 'Chapter II',
            title: 'The Three Sovereign Pillars',
          ),
          const SizedBox(height: 8),
          const Text(
            'An unchanging trilogy governing every timepiece, exceptional jewel and custody protocol.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 16),
          ...pillars.map(
            (pillar) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PillarCard(pillar: pillar),
            ),
          ),
          const SizedBox(height: 12),
          const ChapterHeader(
            chapter: 'Chapter III',
            title: 'The Seal of Place\nVendôme',
          ),
          const SizedBox(height: 16),
          const VendomeSalonCard(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '100%', label: 'SWISS MANUFACTURE'),
              _StatItem(value: '50 Years', label: 'SOVEREIGN WARRANTY'),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'PRIVATE IMMERSION',
              style: TextStyle(
                color: AppColors.primaryGold,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            text: 'EXPLORE THE WORKSHOP MASTERPIECES',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'RESTRICTED ACCESS • ACQUISITIONS BY APPROVAL',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 9,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primaryGold,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
