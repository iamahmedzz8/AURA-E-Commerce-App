import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/settings/presentation/widgets/settings_widget.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          const SettingsEnclaveCard(),
          const SizedBox(height: 16),

          // Section 01
          const SectionHeaderWithLabel(
            title: '01 / APPEARANCE & DISPLAY',
            label: 'High Precision',
          ),
          const SizedBox(height: 8),
          const SettingsCustomTile(
            icon: Icons.nightlight_outlined,
            title: 'Theme Selection',
            subtitle: 'Salon color palette',
            trailing: Text('Nocturnal Dark (Dark)', style: TextStyle(color: AppColors.primaryGold, fontSize: 12)),
            hasArrow: true,
          ),
          const SettingsCustomTile(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Display Currency',
            subtitle: 'Asset prices and valuations',
            trailing: Text('EUR (€) — Euro', style: TextStyle(color: AppColors.textWhite, fontSize: 12)),
            hasArrow: true,
          ),
          const SettingsCustomTile(
            icon: Icons.translate,
            title: 'Workshop Language',
            subtitle: 'Certificate and lease drafting',
            trailing: Text('French (Paris / Gen...', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
            hasArrow: true,
          ),

          const SizedBox(height: 16),

          // Section 02
          const SectionHeaderWithLabel(
            title: '02 / CRYPTOGRAPHIC SECURITY & BIOMETRICS',
            label: 'AES-256 Encrypted',
          ),
          const SizedBox(height: 8),
          SettingsSwitchTile(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication (FaceID / TouchID)',
            subtitle: 'Required for signing escrow agreements and mission orders',
            value: true,
            onChanged: (val) {},
          ),
          const SettingsActionTile(
            icon: Icons.pin_outlined,
            title: '6-Digit Salon PIN',
            subtitle: 'Configured ••••••',
            actionText: 'EDIT',
          ),
          const SettingsActionTile(
            icon: Icons.key_outlined,
            title: 'Private Key Seal',
            subtitle: 'HSM Hardware Encryption',
            actionText: 'ACTIVE — ENCLAVE',
          ),
          const SettingsCustomTile(
            icon: Icons.lock_reset,
            title: 'Change Private Password',
            subtitle: 'Renewed 42 days ago',
            hasArrow: true,
          ),

          const SizedBox(height: 16),

          // Section 03
          const SectionHeaderWithLabel(
            title: '03 / NOTIFICATIONS & DISCREET PROTOCOLS',
            label: 'Encrypted Channels',
          ),
          const SizedBox(height: 8),
          SettingsSwitchTile(
            icon: Icons.local_shipping_outlined,
            title: 'Real-Time Convoy Alerts',
            subtitle: 'Armored GPS tracking & private couriers',
            value: true,
            onChanged: (val) {},
          ),
          SettingsSwitchTile(
            icon: Icons.diamond_outlined,
            title: 'Rare Allocation Previews',
            subtitle: 'Unique pieces and reserved complications',
            value: true,
            onChanged: (val) {},
          ),
          SettingsSwitchTile(
            icon: Icons.chat_bubble_outline,
            title: 'Private Concierge Channel',
            subtitle: 'Secure SMS Gateway & Signal',
            value: false,
            onChanged: (val) {},
          ),

          const SizedBox(height: 16),

          // Section 04
          const SectionHeaderWithLabel(
            title: '04 / LEGAL & PRIVACY',
            label: 'Audited',
          ),
          const SizedBox(height: 8),
          const SettingsNavigationTile(
            icon: Icons.description_outlined,
            title: 'Terms and Conditions of Sale',
          ),
          const SettingsNavigationTile(
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
          ),
          const SettingsNavigationTile(
            icon: Icons.account_balance_outlined,
            title: 'Place Vendôme Notarized Register',
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
                'END SALON SESSION',
                style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'End-to-end encryption • AURA MAISON OS v4.12',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}