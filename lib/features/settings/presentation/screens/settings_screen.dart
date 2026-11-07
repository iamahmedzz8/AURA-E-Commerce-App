import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/settings/presentation/widgets/settings_widget.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: AppStrings.workshopSettings,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SettingsEnclaveCard(),
          const SizedBox(height: 16),

          // Section 01
          const SectionHeaderWithLabel(
            title: AppStrings.sectionAppearanceDisplay,
            label: AppStrings.labelHighPrecision,
          ),
          const SizedBox(height: 8),
          const SettingsCustomTile(
            icon: Icons.nightlight_outlined,
            title: AppStrings.themeSelection,
            subtitle: AppStrings.salonColorPalette,
            trailing: Text('Nocturnal Dark (Dark)', style: TextStyle(color: AppColors.primaryGold, fontSize: 12)),
            hasArrow: true,
          ),
          const SettingsCustomTile(
            icon: Icons.account_balance_wallet_outlined,
            title: AppStrings.displayCurrency,
            subtitle: AppStrings.assetPricesValuations,
            trailing: Text('EUR (€) — Euro', style: TextStyle(color: AppColors.textWhite, fontSize: 12)),
            hasArrow: true,
          ),
          const SettingsCustomTile(
            icon: Icons.translate,
            title: AppStrings.workshopLanguage,
            subtitle: AppStrings.certificateLeaseDrafting,
            trailing: Text('French (Paris / Gen...', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
            hasArrow: true,
          ),

          const SizedBox(height: 16),

          // Section 02
          const SectionHeaderWithLabel(
            title: AppStrings.sectionSecurityBiometrics,
            label: AppStrings.labelAes256Encrypted,
          ),
          const SizedBox(height: 8),
          SettingsSwitchTile(
            icon: Icons.fingerprint,
            title: AppStrings.biometricAuthTitle,
            subtitle: AppStrings.biometricAuthSubtitle,
            value: true,
            onChanged: (val) {},
          ),
          const SettingsActionTile(
            icon: Icons.pin_outlined,
            title: AppStrings.salonPinTitle,
            subtitle: 'Configured ••••••',
            actionText: 'EDIT',
          ),
          const SettingsActionTile(
            icon: Icons.key_outlined,
            title: AppStrings.privateKeySeal,
            subtitle: 'HSM Hardware Encryption',
            actionText: 'ACTIVE — ENCLAVE',
          ),
          const SettingsCustomTile(
            icon: Icons.lock_reset,
            title: AppStrings.changePrivatePassword,
            subtitle: 'Renewed 42 days ago',
            hasArrow: true,
          ),

          const SizedBox(height: 16),

          // Section 03
          const SectionHeaderWithLabel(
            title: AppStrings.sectionNotifications,
            label: AppStrings.labelEncryptedChannels,
          ),
          const SizedBox(height: 8),
          SettingsSwitchTile(
            icon: Icons.local_shipping_outlined,
            title: AppStrings.realTimeConvoyAlerts,
            subtitle: 'Armored GPS tracking & private couriers',
            value: true,
            onChanged: (val) {},
          ),
          SettingsSwitchTile(
            icon: Icons.diamond_outlined,
            title: AppStrings.rareAllocationPreviews,
            subtitle: 'Unique pieces and reserved complications',
            value: true,
            onChanged: (val) {},
          ),
          SettingsSwitchTile(
            icon: Icons.chat_bubble_outline,
            title: AppStrings.privateConciergeChannel,
            subtitle: 'Secure SMS Gateway & Signal',
            value: false,
            onChanged: (val) {},
          ),

          const SizedBox(height: 16),

          // Section 04
          const SectionHeaderWithLabel(
            title: AppStrings.sectionLegalPrivacy,
            label: AppStrings.labelAudited,
          ),
          const SizedBox(height: 8),
          const SettingsNavigationTile(
            icon: Icons.description_outlined,
            title: AppStrings.termsConditionsSale,
          ),
          const SettingsNavigationTile(
            icon: Icons.shield_outlined,
            title: AppStrings.privacyPolicy,
          ),
          const SettingsNavigationTile(
            icon: Icons.account_balance_outlined,
            title: AppStrings.notarizedRegister,
          ),

          const SizedBox(height: 24),

          // End Salon Session Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.withValues(alpha: 0.6)),
                backgroundColor: Colors.red.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.power_settings_new, color: Colors.red, size: 16),
              label: const Text(
                AppStrings.endSalonSession,
                style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              AppStrings.endToEndEncryptionFooter,
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}