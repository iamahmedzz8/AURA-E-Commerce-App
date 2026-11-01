
import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        subtitle: 'Workshop Settings',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(),

            const SizedBox(height: 24),

            _buildRegisterHeader(),

            const SizedBox(height: 20),

            const SectionHeader(
              title: 'HONORIFIC TITLE / SALUTATION',
            ),

            _buildTitleChips(),

            const SizedBox(height: 16),

            _buildInputField(
              label: 'FULL NAME',
              initialValue: 'Baroness Victoria de Rothschild',
              icon: Icons.lock_outline,
            ),

            const SizedBox(height: 16),

            _buildInputField(
              label: 'SECURE EMAIL ADDRESS',
              initialValue: 'v.rothschild@vendome.ch',
              icon: Icons.verified_user_outlined,
            ),

            const SizedBox(height: 16),

            _buildInputField(
              label: 'SECURE DIRECT LINE',
              initialValue: '+33 142 68 00 00',
              icon: Icons.phone_outlined,
            ),

            const SizedBox(height: 16),

            _buildDropdownField(
              label: 'BILLING & PAYMENT CURRENCY',
              value: 'EUR (€) — European Euro',
            ),

            const SizedBox(height: 16),

            _buildDropdownField(
              label: 'COMMUNICATION & CORRESPONDENCE LANGUAGE',
              value: 'French (Maison Vendôme)',
            ),

            const SizedBox(height: 24),

            PrimaryButton(
              text: 'SAVE CHANGES',
              onPressed: () {},
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL CHANGES',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Image

  Widget _buildProfileImage() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryGold,
                    width: 1.5,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/edit_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 12,
                    color: AppColors.background,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            'Distinguished Member No. 048-AURA',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Register Header

  Widget _buildRegisterHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Private Client Register',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 4),

        Text(
          'Biometric authentication and regnal titles recorded under watchmaking seal',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // Honorific Title Chips

  Widget _buildTitleChips() {
    return Row(
      children: [
        _buildChip('Baroness', isSelected: true),

        const SizedBox(width: 8),

        _buildChip('Count'),

        const SizedBox(width: 8),

        _buildChip('Sir'),
      ],
    );
  }

  Widget _buildChip(
    String label, {
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryGold
            : AppColors.inputBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryGold
              : AppColors.cardBorder,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppColors.background
              : AppColors.textWhite,
          fontSize: 12,
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }

  // Input Field

  Widget _buildInputField({
    required String label,
    required String initialValue,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: label),

        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputBg,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            suffixIcon: icon != null
                ? Icon(
                    icon,
                    color: AppColors.primaryGold,
                    size: 16,
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColors.cardBorder,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColors.primaryGold,
                width: 1.5,
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColors.cardBorder,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown Field

  Widget _buildDropdownField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: label),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 13,
                  ),
                ),
              ),

              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
