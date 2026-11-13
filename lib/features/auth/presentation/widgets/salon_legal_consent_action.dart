import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Element 4: Salon Legal Consent & Application Action Button
/// Figma Nodes: 26:105 ("Margin" -> "Overlay") & 26:116 ("Container" -> "Button")
class SalonLegalConsentAction extends StatefulWidget {
  final VoidCallback? onCreateAccountTap;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyPolicyTap;

  const SalonLegalConsentAction({
    super.key,
    this.onCreateAccountTap,
    this.onTermsTap,
    this.onPrivacyPolicyTap,
  });

  @override
  State<SalonLegalConsentAction> createState() =>
      _SalonLegalConsentActionState();
}

class _SalonLegalConsentActionState extends State<SalonLegalConsentAction> {
  bool _isConsentAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          // 1. Legal Consent Checkbox Card
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _isConsentAccepted = !_isConsentAccepted;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cardInactive,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.chipBorder, width: 0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gold Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: _isConsentAccepted
                          ? AppColors.goldAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: _isConsentAccepted
                            ? AppColors.goldAccent
                            : AppColors.chipBorder,
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _isConsentAccepted
                        ? const Icon(
                            Icons.check,
                            size: 13,
                            color: AppColors.iconDark,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),

                  // Legal RichText
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.termsConsentPrefix,
                            style: AppStyles.consentRegularText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.privacyPolicyLink,
                            style: AppStyles.consentLinkText.copyWith(
                              color: AppColors.goldAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onPrivacyPolicyTap,
                          ),
                          TextSpan(
                            text: AppStrings.termsConsentSuffix,
                            style: AppStyles.consentRegularText.copyWith(
                              color: AppColors.textSecondary,
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
          const SizedBox(height: 16),

          // 2. Primary CTA: CREATE MY PRIVILEGE ACCOUNT
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _isConsentAccepted ? widget.onCreateAccountTap : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _isConsentAccepted
                    ? AppColors.goldAccent
                    : AppColors.goldAccent.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
                boxShadow: _isConsentAccepted
                    ? [
                        BoxShadow(
                          color: AppColors.goldAccent.withValues(alpha: 0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.createPrivilegeAccountAction,
                    style: AppStyles.createPrivilegeAccountButton.copyWith(
                      color: AppColors.iconDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
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
