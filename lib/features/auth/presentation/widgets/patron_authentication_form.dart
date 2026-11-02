import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class PatronAuthenticationForm extends StatefulWidget {
  final TextEditingController? idController;
  final TextEditingController? passphraseController;
  final VoidCallback? onEnterSalonTap;
  final VoidCallback? onForgotPasswordTap;

  const PatronAuthenticationForm({
    super.key,
    this.idController,
    this.passphraseController,
    this.onEnterSalonTap,
    this.onForgotPasswordTap,
  });

  @override
  State<PatronAuthenticationForm> createState() =>
      _PatronAuthenticationFormState();
}

class _PatronAuthenticationFormState extends State<PatronAuthenticationForm> {
  late final TextEditingController _idController;
  late final TextEditingController _passphraseController;
  bool _obscurePassword = true;
  bool _rememberKey = true;

  @override
  void initState() {
    super.initState();
    _idController = widget.idController ??
        TextEditingController(text: AppStrings.patronIdPlaceholder);
    _passphraseController = widget.passphraseController ??
        TextEditingController(text: AppStrings.passphrasePlaceholder);
  }

  @override
  void dispose() {
    if (widget.idController == null) _idController.dispose();
    if (widget.passphraseController == null) _passphraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Field 1: Patron Identifier ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.patronIdCipherLabel,
                style: AppStyles.vipFieldLabel.copyWith(
                  color: AppColors.specsCream,
                ),
              ),
              Text(
                AppStrings.salonVendomeBadge,
                style: AppStyles.vipFieldBadge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardInactive,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.chipBorder,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.badge_outlined,
                  size: 16,
                  color: AppColors.goldAccent.withValues(alpha: 0.70),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _idController,
                    style: AppStyles.vipInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    cursorColor: AppColors.goldAccent,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Field 2: Workshop Passphrase ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.workshopPassphraseLabel,
                style: AppStyles.vipFieldLabel.copyWith(
                  color: AppColors.specsCream,
                ),
              ),
              Text(
                AppStrings.highSecurityBadge,
                style: AppStyles.vipFieldBadge.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardInactive,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.chipBorder,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: AppColors.goldAccent.withValues(alpha: 0.70),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _passphraseController,
                    obscureText: _obscurePassword,
                    style: AppStyles.vipInputText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    cursorColor: AppColors.goldAccent,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // ── Micro Strength Segment Gauge ──
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Utility Row: Remember Salon Key & Forgotten Passphrase ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember Salon Key
              GestureDetector(
                onTap: () {
                  setState(() => _rememberKey = !_rememberKey);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _rememberKey
                            ? AppColors.goldAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: AppColors.goldAccent,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _rememberKey
                          ? const Icon(
                              Icons.check,
                              size: 11,
                              color: AppColors.iconDark,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.rememberSalonKey,
                      style: AppStyles.vipRememberLabel.copyWith(
                        color: AppColors.textMutedBeige,
                      ),
                    ),
                  ],
                ),
              ),

              // Forgotten Passphrase Link
              GestureDetector(
                onTap: widget.onForgotPasswordTap,
                child: Text(
                  AppStrings.forgottenPassphrase,
                  style: AppStyles.vipRememberLabel.copyWith(
                    color: AppColors.goldAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Primary Action CTA: ENTER THE PRIVATE SALON ──
          GestureDetector(
            onTap: widget.onEnterSalonTap,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.goldAccent,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.enterPrivateSalonAction,
                    style: AppStyles.vipEnterSalonButton.copyWith(
                      color: AppColors.iconDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.lock_open_rounded,
                    size: 14,
                    color: AppColors.iconDark,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
