import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/aura_medallion_header.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/global_sync_card.dart';
import '../widgets/password_criteria_gauge.dart';
import '../widgets/tamper_proof_seal_card.dart';
import 'vip_member_sign_in_screen.dart';

/// Reset Password — New Password / Set a New Seal Screen (Node 6:325)
/// Cryptographic password reset enforcing Haute Horlogerie security standards.
/// Connected directly to [ResetPasswordCubit].
class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPassphraseController = TextEditingController();
  final _confirmPassphraseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool get _hasMinLength => _newPassphraseController.text.length >= 8;
  bool get _hasUppercase =>
      RegExp(r'[A-Z]').hasMatch(_newPassphraseController.text);
  bool get _hasDigit =>
      RegExp(r'[0-9]').hasMatch(_newPassphraseController.text);
  bool get _hasSpecialChar => RegExp(
    r'[!@#\$%^&*(),.?":{}|<>]',
  ).hasMatch(_newPassphraseController.text);

  int get _score {
    int s = 0;
    if (_hasMinLength) s++;
    if (_hasUppercase) s++;
    if (_hasDigit) s++;
    if (_hasSpecialChar) s++;
    return s;
  }

  bool get _passwordsMatch =>
      _newPassphraseController.text.isNotEmpty &&
      _newPassphraseController.text == _confirmPassphraseController.text;

  @override
  void initState() {
    super.initState();
    _newPassphraseController.addListener(() => setState(() {}));
    _confirmPassphraseController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPassphraseController.dispose();
    _confirmPassphraseController.dispose();
    super.dispose();
  }

  void _updatePassphrase(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_score < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.obsidianElevated,
          content: Text(
            AppStrings.passphraseCriteriaRequirement,
            style: TextStyle(color: AppColors.ivory),
          ),
        ),
      );
      return;
    }

    if (!_passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.obsidianElevated,
          content: Text(
            AppStrings.passphrasesMustMatch,
            style: TextStyle(color: AppColors.ivory),
          ),
        ),
      );
      return;
    }

    context.read<ResetPasswordCubit>().resetPassword(
      email: widget.email,
      otp: widget.otp,
      newPassword: _newPassphraseController.text,
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.obsidianDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.gold.withValues(alpha: 0.4)),
        ),
        title: const Row(
          children: [
            Icon(Icons.verified_outlined, color: AppColors.gold, size: 24),
            SizedBox(width: 10),
            Text(
              AppStrings.privateSealUpdated,
              style: TextStyle(
                fontFamily: 'serif',
                color: AppColors.ivory,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          AppStrings.privateSealUpdatedDesc,
          style: TextStyle(color: AppColors.luxuryMuted, fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.obsidianDark,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const VipMemberSignInScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text(
              AppStrings.returnToSalonSignInUpper,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (_) => sl<ResetPasswordCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.obsidian,
        body: SafeArea(
          child: Column(
            children: [
              AuthTopBar(
                title: AppStrings.resetPasswordTitle,
                onBack: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.obsidianElevated,
                          content: Text(
                            state.message,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      );
                    } else if (state is ResetPasswordSuccess) {
                      _showSuccessDialog(context);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is ResetPasswordLoading;

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AuraMedallionHeader(
                              icon: Icons.lock_reset,
                              tag: AppStrings.fineWatchmakingEncryption,
                              title: AppStrings.setANewSeal,
                              subtitle: AppStrings.setANewSealSubtitle,
                            ),
                            const SizedBox(height: 22),
                            _buildNewPassphraseCard(),
                            const SizedBox(height: 14),
                            _buildConfirmPassphraseCard(),
                            const SizedBox(height: 14),
                            const GlobalSyncCard(),
                            const SizedBox(height: 20),
                            _buildActionButton(context, isLoading),
                            const SizedBox(height: 12),
                            _buildAdvisorLink(),
                            const SizedBox(height: 24),
                            const TamperProofSealCard(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewPassphraseCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.newPassphrase,
                style: TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.obsidianDark,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _score == 4
                        ? AppColors.emerald.withValues(alpha: 0.6)
                        : AppColors.gold.withValues(alpha: 0.3),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  _score == 4
                      ? AppStrings.optimalSecurity
                      : AppStrings.cipherIncomplete,
                  style: TextStyle(
                    color: _score == 4
                        ? AppColors.emerald
                        : AppColors.gold.withValues(alpha: 0.8),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _newPassphraseController,
            obscureText: _obscureNew,
            style: const TextStyle(
              color: AppColors.ivory,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: '••••••••••••',
              hintStyle: TextStyle(
                color: AppColors.luxuryMuted.withValues(alpha: 0.5),
                letterSpacing: 2,
              ),
              filled: true,
              fillColor: AppColors.obsidianDark,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.gold,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNew ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: AppColors.luxuryMuted,
                ),
                onPressed: () => setState(() => _obscureNew = !_obscureNew),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.obsidianBorder,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.obsidianBorder,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.gold, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          PasswordCriteriaGauge(
            score: _score,
            hasMinLength: _hasMinLength,
            hasUppercase: _hasUppercase,
            hasDigit: _hasDigit,
            hasSpecialChar: _hasSpecialChar,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPassphraseCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.confirmPassphrase,
                style: TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              if (_passwordsMatch)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.emerald.withValues(alpha: 0.5),
                      width: 0.8,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, size: 10, color: AppColors.emerald),
                      SizedBox(width: 3),
                      Text(
                        AppStrings.exactMatch,
                        style: TextStyle(
                          color: AppColors.emerald,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmPassphraseController,
            obscureText: _obscureConfirm,
            style: const TextStyle(
              color: AppColors.ivory,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: '••••••••••••',
              hintStyle: TextStyle(
                color: AppColors.luxuryMuted.withValues(alpha: 0.5),
                letterSpacing: 2,
              ),
              filled: true,
              fillColor: AppColors.obsidianDark,
              prefixIcon: const Icon(
                Icons.lock_clock_outlined,
                size: 18,
                color: AppColors.gold,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: AppColors.luxuryMuted,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.obsidianBorder,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.obsidianBorder,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: _passwordsMatch ? AppColors.emerald : AppColors.gold,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.obsidianDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 4,
        ),
        onPressed: isLoading ? null : () => _updatePassphrase(context),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.obsidianDark,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.updatePrivateSeal,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.8,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
      ),
    );
  }

  Widget _buildAdvisorLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.obsidianElevated,
              content: Text(
                AppStrings.connectingConciergeLiaison,
                style: TextStyle(color: AppColors.ivory),
              ),
            ),
          );
        },
        child: const Text(
          AppStrings.needDedicatedAdvisor,
          style: TextStyle(
            color: AppColors.luxuryMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
