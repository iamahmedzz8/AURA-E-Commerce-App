import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/features/admin/admin_dashdoard/presentation/screens/admin_dashboard_screen.dart';
import 'package:aura_maison_e_commerce/features/profile/data/models/profile_model.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/screens/edit_profile.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/screens/concierge_contactform.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/screens/police_privacy.dart';
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/change_password_screen.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/screens/user_addresses_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileModel.sample();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

              const SectionHeader(title: 'Workshop Ledger & Security Services'),

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

              ProfileMenuTile(
                icon: Icons.location_on_outlined,
                title: 'My Addresses',
                subtitle: 'Manage your saved delivery addresses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<AddressesCubit>(),
                        child: const UserAddressesScreen(),
                      ),
                    ),
                  );
                },
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

              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                ),
                child: const ProfileMenuTile(
                  icon: Icons.security,
                  title: 'Security & Hardware Key',
                  subtitle: 'Hardware Enclave, FaceID, Dual-Vault Auth',
                ),
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
                        side: const BorderSide(color: AppColors.primaryGold),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.primaryGold,
                            size: 17,
                          ),
                          SizedBox(width: 8),
                          const Text(
                            'DIRECT LINE',
                            style: TextStyle(
                              color: AppColors.primaryGold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.cardBorder),
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
              const SizedBox(height: 12),

              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.primaryGold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: AppColors.primaryGold,
                        size: 17,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'CHANGE PASSWORD',
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryGold),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboardScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.admin_panel_settings_outlined,
                        color: AppColors.primaryGold,
                        size: 17,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'ADMIN ACCESS',
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
