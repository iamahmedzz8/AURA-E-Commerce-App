import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/core/utils/validators.dart';
import 'package:flutter/material.dart';

class PasswordRules {
  static const int minLength = 8;

  static bool hasMinLength(String p) => p.length >= minLength;

  static bool hasUppercase(String p) => RegExp(r'[A-Z]').hasMatch(p);

  static bool hasDigit(String p) => RegExp(r'\d').hasMatch(p);

  static bool hasSpecial(String p) => RegExp(r'[^A-Za-z0-9\s]').hasMatch(p);

  static int score(String p) => [
    hasMinLength(p),
    hasUppercase(p),
    hasDigit(p),
    hasSpecial(p),
  ].where((met) => met).length;

  static bool isValid(String p) => score(p) == 4;
}

class PrivilegeRegistrationForm extends StatefulWidget {
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;

  const PrivilegeRegistrationForm({
    super.key,
    this.firstNameController,
    this.lastNameController,
    this.emailController,
    this.phoneController,
    this.passwordController,
  });

  @override
  State<PrivilegeRegistrationForm> createState() =>
      _PrivilegeRegistrationFormState();
}

class _PrivilegeRegistrationFormState extends State<PrivilegeRegistrationForm> {
  static const String _firstNameLabel = 'FIRST NAME';
  static const String _lastNameLabel = 'LAST NAME';

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  bool _obscurePassword = true;

  final String _selectedCountryCode = AppStrings.phoneCountryPrefix;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        widget.firstNameController ?? TextEditingController();

    _lastNameController = widget.lastNameController ?? TextEditingController();

    _emailController = widget.emailController ?? TextEditingController();

    _phoneController = widget.phoneController ?? TextEditingController();

    _passwordController = widget.passwordController ?? TextEditingController();

    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);

    if (widget.firstNameController == null) {
      _firstNameController.dispose();
    }

    if (widget.lastNameController == null) {
      _lastNameController.dispose();
    }

    if (widget.emailController == null) {
      _emailController.dispose();
    }

    if (widget.phoneController == null) {
      _phoneController.dispose();
    }

    if (widget.passwordController == null) {
      _passwordController.dispose();
    }

    super.dispose();
  }

  String get _strengthLabel {
    switch (PasswordRules.score(_passwordController.text)) {
      case 4:
        return AppStrings.veryStrongBadge;
      case 3:
        return 'STRONG';
      case 2:
        return 'FAIR';
      default:
        return 'WEAK';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String password = _passwordController.text;
    final int strengthScore = PasswordRules.score(password);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIRST NAME + LAST NAME
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildNameField(
                  label: _firstNameLabel,
                  hint: 'First name',
                  controller: _firstNameController,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildNameField(
                  label: _lastNameLabel,
                  hint: 'Last name',
                  controller: _lastNameController,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // EMAIL LABEL
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

          SizedBox(height: 6),

          // EMAIL INPUT + VALIDATION
          _buildValidatedInput(
            controller: _emailController,
            validator: (email) {
              return Validator.validateEmail(email.toString());
            },
            keyboardType: TextInputType.emailAddress,
            hint: AppStrings.privateEmailPlaceholder,
            suffixIcon: Icon(
              Icons.mail_outline,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: 20),

          // PASSWORD LABEL
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
                _strengthLabel,
                style: AppStyles.passwordIndicatorBadge.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
            ],
          ),

          SizedBox(height: 6),

          // PASSWORD INPUT
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
                      contentPadding: EdgeInsets.symmetric(
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

          SizedBox(height: 8),

          // PASSWORD STRENGTH
          Row(
            children: [
              for (int i = 0; i < 4; i++) ...[
                if (i > 0) SizedBox(width: 6),
                _buildStrengthSegment(active: i < strengthScore),
              ],
            ],
          ),

          SizedBox(height: 20),

          // PASSWORD CRITERIA
          Container(
            padding: EdgeInsets.all(12),
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
                        PasswordRules.hasMinLength(password),
                      ),
                    ),
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaUppercase,
                        PasswordRules.hasUppercase(password),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaDigit,
                        PasswordRules.hasDigit(password),
                      ),
                    ),
                    Expanded(
                      child: _buildCriteriaItem(
                        AppStrings.criteriaSpecialSymbol,
                        PasswordRules.hasSpecial(password),
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

  // NAME FIELD
  Widget _buildNameField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.formFieldLabel.copyWith(color: AppColors.goldAccent),
        ),
        SizedBox(height: 6),
        _buildInputContainer(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            style: AppStyles.formInputText.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 13,
              ),
              hintText: hint,
              hintStyle: AppStyles.formInputText.copyWith(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // VALIDATED INPUT

  Widget _buildValidatedInput({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    required String hint,
    Widget? suffixIcon,
  }) {
    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.cardInactive,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.chipBorder, width: 0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      style: AppStyles.formInputText.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      onChanged: (value) {
                        field.didChange(value);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                        hintText: hint,
                        hintStyle: AppStyles.formInputText.copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                  if (suffixIcon != null)
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: suffixIcon,
                    ),
                ],
              ),
            ),

            if (field.hasError) ...[
              SizedBox(height: 5),
              Text(
                field.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  // INPUT CONTAINER
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

  // PASSWORD STRENGTH SEGMENT
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

  // PASSWORD CRITERIA ITEM
  Widget _buildCriteriaItem(String label, bool met) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: met ? AppColors.statusGreen : AppColors.textSecondary,
        ),
        SizedBox(width: 6),
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
