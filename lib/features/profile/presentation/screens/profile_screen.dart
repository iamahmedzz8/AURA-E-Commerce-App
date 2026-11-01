
import 'package:aura_maison_e_commerce/features/profile/data/models/profile_model.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/screens/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileModel.sample();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              const SizedBox(height: 20),

              ProfileCard(
                name: profile.name,
                initials: profile.initials,
                membership: profile.membership,
                location: profile.location,
                commissions: profile.commissions,
                vaultHoldings: profile.vaultHoldings,
                status: profile.status,
              ),

              const SizedBox(height: 16),
              const TransitCard(),

              const SectionHeader(
                title: 'Workshop Ledger & Security Services',
              ),

              const ProfileMenuTile(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Vault Acquisitions',
                subtitle: '3 Pieces Registered • Blockchain Provenance',
              ),

              const ProfileMenuTile(
                icon: Icons.local_shipping_outlined,
                title: 'Private Orders & Live Transit',
                subtitle: '1 Active in Transit from Geneva Salon',
              ),

              const ProfileMenuTile(
                icon: Icons.design_services_outlined,
                title: 'Bespoke Commissions',
                subtitle: '1 Custom Tourbillon Pending CAD Approval',
              ),

              const ProfileMenuTile(
                icon: Icons.bookmark_border,
                title: 'Saved Vault Wishlist',
                subtitle: '5 Masterpieces Archival for Viewing',
              ),

              const ProfileMenuTile(
                icon: Icons.security,
                title: 'Security & Hardware Key',
                subtitle: 'Hardware Enclave, FaceID, Dual-Vault Auth',
              ),

              const ProfileMenuTile(
                icon: Icons.tune,
                title: 'Curated Preferences',
                subtitle: 'USD (\$) | French / English • Midnight',
              ),

              const SizedBox(height: 16),

              AdvisorCard(advisorName: profile.advisorName),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.primaryGold,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'DIRECT LINE',
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.cardBorder,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'SALON CRYPT',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              PrimaryButton(
                text: 'EDIT PROFILE',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
