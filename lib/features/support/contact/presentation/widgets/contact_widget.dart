import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/support/contact/data/models/contact_model.dart';
import 'package:flutter/material.dart';

// Displays one salon using its model data.
//
// Reusable widget:
// Pass a different ContactModel to display another salon.
// Controllers are passed from the parent screen and are not
// created or disposed inside this widget.
class ConciergeSalonCard extends StatelessWidget {
  final ContactModel salon;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const ConciergeSalonCard({
    super.key,
    required this.salon,
    required this.phoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Salon image and title.
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Stack(
              children: [
                Image.asset(
                  salon.imagePath,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        salon.salonCategory,
                        style: const TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        salon.salonName,
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Salon information.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textMuted,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        salon.address,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Show additional information only when available.
                if (salon.vaultExpertise != null &&
                    salon.accreditation != null) ...[
                  _buildInfoRow('VAULTS & EXPERTISE', salon.vaultExpertise!),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'ACCREDITATION',
                    salon.accreditation!,
                    valueColor: AppColors.primaryGold,
                  ),
                  const SizedBox(height: 12),
                ],

                _buildInfoRow(salon.hoursLabel, salon.hoursValue),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: AppColors.cardBorder),
                ),

                // Contact information fields.
                ContactInputRow(
                  icon: Icons.shield_outlined,
                  label: salon.phoneLabel,
                  controller: phoneController,
                ),

                const SizedBox(height: 10),

                ContactInputRow(
                  icon: Icons.email_outlined,
                  label: salon.emailLabel,
                  controller: emailController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color valueColor = AppColors.textWhite,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: valueColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable contact input field.
// The parent screen controls the TextEditingController lifecycle.
class ContactInputRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;

  const ContactInputRow({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGold, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryGold),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Displays the salon's strategic coordinates.
class StrategicRadarCard extends StatelessWidget {
  const StrategicRadarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.radar, color: AppColors.primaryGold, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'STRATEGIC COORDINATES',
                    style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Text(
                '48.8671° N, 2.3294° E',
                style: TextStyle(color: AppColors.textMuted, fontSize: 9),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryGold.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                ),
                const Positioned(
                  top: 30,
                  left: 80,
                  child: Text(
                    'PARIS 01',
                    style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 25,
                  right: 90,
                  child: Text(
                    'GENÈVE 12',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'AES-256 ENCRYPTED NETWORK',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Each salon has an independent armored vestibule and a fitting room isolated from public cellular networks.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Displays the high-discretion security protocol information.
class HighDiscretionProtocolCard extends StatelessWidget {
  const HighDiscretionProtocolCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.security, color: AppColors.primaryGold, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'HIGH-DISCRETION PROTOCOL',
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Secure transfer of unique pieces under an auctioneer’s mandate or armed guard available on request.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
