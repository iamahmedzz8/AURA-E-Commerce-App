import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/features/admin/admin_dashdoard/presentation/screens/admin_dashboard_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
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

              const SectionHeader(title: AppStrings.workshopLedgerSecurity),

              const ProfileMenuTile(
                icon: Icons.account_balance_wallet_outlined,
                title: AppStrings.vaultAcquisitions,
                subtitle: AppStrings.vaultAcquisitionsSubtitle,
              ),

              const ProfileMenuTile(
                icon: Icons.local_shipping_outlined,
                title: AppStrings.privateOrdersTransit,
                subtitle: AppStrings.privateOrdersTransitSubtitle,
              ),

              ProfileMenuTile(
                icon: Icons.location_on_outlined,
                title: AppStrings.myAddresses,
                subtitle: AppStrings.manageSavedAddresses,
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
                title: AppStrings.bespokeCommissions,
                subtitle: AppStrings.bespokeCommissionsSubtitle,
              ),

              const ProfileMenuTile(
                icon: Icons.bookmark_border,
                title: AppStrings.savedVaultWishlist,
                subtitle: AppStrings.savedVaultWishlistSubtitle,
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
                  title: AppStrings.securityHardwareKey,
                  subtitle: AppStrings.securityHardwareKeySubtitle,
                ),
              ),

              const ProfileMenuTile(
                icon: Icons.tune,
                title: AppStrings.curatedPreferences,
                subtitle: AppStrings.curatedPreferencesSubtitle,
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
                            AppStrings.directLine,
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
                            AppStrings.adminAccess,
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

              const SizedBox(height: 16),

              PrimaryButton(
                text: AppStrings.editProfile,
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
                        AppStrings.changePasswordTitle,
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        backgroundColor: AppColors.cardBg,
                        title: const Text('Logout'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text(
                              'LOG OUT',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirm != true) return;

                    try {
                      await sl<AuthCubit>().logout();

                      if (!context.mounted) return;

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const VipMemberSignInScreen(),
                        ),
                        (route) => false,
                      );
                    } catch (e) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: $e')),
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('LOG OUT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
