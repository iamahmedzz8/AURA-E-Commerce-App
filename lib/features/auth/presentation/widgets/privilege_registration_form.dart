import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Element 3: Privilege Registration Form & Password Criteria
/// Figma Nodes: 26:27 to 26:84
class PrivilegeRegistrationForm extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;

  const PrivilegeRegistrationForm({
    super.key,
    this.nameController,
    this.emailController,
    this.phoneController,
    this.passwordController,
  });

  @override
  State<PrivilegeRegistrationForm> createState() =>
      _PrivilegeRegistrationFormState();
}

class _PrivilegeRegistrationFormState extends State<PrivilegeRegistrationForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  bool _obscurePassword = false;
  final String _selectedCountryCode = AppStrings.phoneCountryPrefix;

  @override
  void initState() {
    super.initState();
    _nameController =
        widget.nameController ??
        TextEditingController(text: AppStrings.fullNamePlaceholder);
    _emailController =
        widget.emailController ??
        TextEditingController(text: AppStrings.privateEmailPlaceholder);
    _phoneController =
        widget.phoneController ??
        TextEditingController(text: AppStrings.mobilePhonePlaceholder);
    _passwordController =
        widget.passwordController ??
        TextEditingController(text: AppStrings.securePasswordPlaceholder);
  }

  @override
  void dispose() {
    if (widget.nameController == null) _nameController.dispose();
    if (widget.emailController == null) _emailController.dispose();
    if (widget.phoneController == null) _phoneController.dispose();
    if (widget.passwordController == null) _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. FULL NAME FIELD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.fullNameLabel,
                style: AppStyles.formFieldLabel.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              Text(
                AppStrings.titleSurnameBadge,
                style: AppStyles.formFieldSubBadge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildInputContainer(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    style: AppStyles.formInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      hintText: AppStrings.fullNamePlaceholder,
                      hintStyle: AppStyles.formInputText.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.person_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. PRIVATE EMAIL ADDRESS FIELD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.privateEmailLabel,
                style: AppStyles.formFieldLabel.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              Text(
                AppStrings.encryptedProtocolBadge,
                style: AppStyles.formFieldSubBadge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildInputContainer(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppStyles.formInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      hintText: AppStrings.privateEmailPlaceholder,
                      hintStyle: AppStyles.formInputText.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.mail_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. MOBILE PHONE NUMBER FIELD
          Text(
            AppStrings.mobilePhoneLabel,
            style: AppStyles.formFieldLabel.copyWith(
              color: AppColors.goldAccent,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              // Country Code Selector
              _buildInputContainer(
                width: 112,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCountryCode,
                        style: AppStyles.formInputText.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.goldAccent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Phone Number Input
              Expanded(
                child: _buildInputContainer(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: AppStyles.formInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      hintText: AppStrings.mobilePhonePlaceholder,
                      hintStyle: AppStyles.formInputText.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4. SECURE PASSWORD FIELD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.securePasswordLabel,
                style: AppStyles.formFieldLabel.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              Text(
                AppStrings.veryStrongBadge,
                style: AppStyles.passwordIndicatorBadge.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildInputContainer(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: AppStyles.formInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      hintText: AppStrings.securePasswordPlaceholder,
                      hintStyle: AppStyles.formInputText.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 4-Segment Robustness Gauge
          Row(
            children: [
              _buildStrengthSegment(active: true),
              const SizedBox(width: 6),
              _buildStrengthSegment(active: true),
              const SizedBox(width: 6),
              _buildStrengthSegment(active: true),
              const SizedBox(width: 6),
              _buildStrengthSegment(active: false),
            ],
          ),
          const SizedBox(height: 8),

          // Password Criteria Grid Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardInactive,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.chipBorder, width: 0.5),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaMinCharacters,
                        true,
                      ),
                    ),
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaUppercase,
                        true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildCriteriaItem(AppStrings.criteriaDigit, true),
                    ),
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaSpecialSymbol,
                        true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputContainer({required Widget child, double? width}) {
    return Container(
      width: width,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.cardInactive,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.chipBorder, width: 0.5),
      ),
      child: child,
    );
  }

  Widget _buildStrengthSegment({required bool active}) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: active ? AppColors.goldAccent : AppColors.statusReservedBg,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildCriteriaItem(String label, bool met) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: met ? AppColors.statusGreen : AppColors.textSecondary,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: AppStyles.passwordCriteriaText.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
