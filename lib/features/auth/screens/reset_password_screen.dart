import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/aura_medallion_header.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/global_sync_card.dart';
import '../widgets/password_criteria_gauge.dart';
import '../widgets/tamper_proof_seal_card.dart';
import 'login_screen.dart';

/// Reset Password — New Password / Set a New Seal Screen (Node 6:325)
/// Cryptographic password reset enforcing Haute Horlogerie security standards.
/// TODO: Connect [updatePassphrase] to your backend API via [ResetPasswordCubit].
class ResetPasswordScreen extends StatefulWidget {
  final String? email;
  const ResetPasswordScreen({super.key, this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPassphraseController = TextEditingController();
  final _confirmPassphraseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  bool get _hasMinLength => _newPassphraseController.text.length >= 8;
  bool get _hasUppercase =>
      RegExp(r'[A-Z]').hasMatch(_newPassphraseController.text);
  bool get _hasDigit =>
      RegExp(r'[0-9]').hasMatch(_newPassphraseController.text);
  bool get _hasSpecialChar =>
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(_newPassphraseController.text);

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

  void _updatePassphrase() {
    FocusScope.of(context).unfocus();

    if (_score < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Your new passphrase must satisfy all four Fine Watchmaking security criteria.',
          ),
        ),
      );
      return;
    }

    if (!_passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Both passphrases must match exactly.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulated API dispatch (connect to ResetPasswordCubit)
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.obsidianDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.gold.withOpacity(0.4)),
          ),
          title: const Row(
            children: [
              Icon(Icons.verified_outlined, color: AppColors.gold, size: 24),
              SizedBox(width: 10),
              Text(
                'Private Seal Updated',
                style: TextStyle(
                  fontFamily: 'serif',
                  color: AppColors.ivory,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: const Text(
            'Your new cryptographic cipher has been synchronised across all authorized salon nodes.',
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
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'RETURN TO SALON SIGN-IN',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Column(
          children: [
            AuthTopBar(
              title: 'Reset Password',
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuraMedallionHeader(
                        icon: Icons.lock_reset,
                        tag: 'FINE WATCHMAKING ENCRYPTION',
                        title: 'Set a New Seal',
                        subtitle:
                            'Your new passphrase must meet\nthe security criteria of Fine Watchmaking.',
                      ),
                      const SizedBox(height: 22),
                      _buildNewPassphraseCard(),
                      const SizedBox(height: 14),
                      _buildConfirmPassphraseCard(),
                      const SizedBox(height: 14),
                      const GlobalSyncCard(),
                      const SizedBox(height: 20),
                      _buildActionButton(),
                      const SizedBox(height: 12),
                      _buildAdvisorLink(),
                      const SizedBox(height: 24),
                      const TamperProofSealCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
            color: Colors.black.withOpacity(0.35),
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
                'NEW PASSPHRASE',
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
                        ? AppColors.emerald.withOpacity(0.6)
                        : AppColors.gold.withOpacity(0.3),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  _score == 4 ? 'MAXIMUM SECURITY' : 'SECURITY LEVEL: $_score/4',
                  style: TextStyle(
                    color: _score == 4 ? AppColors.emerald : AppColors.gold,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
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
              hintText: 'Chronos#2024Atelier',
              hintStyle: TextStyle(
                color: AppColors.luxuryMuted.withOpacity(0.55),
                fontSize: 13.5,
              ),
              filled: true,
              fillColor: AppColors.obsidianDark,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.gold,
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscureNew = !_obscureNew),
                icon: Icon(
                  _obscureNew
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.luxuryMuted,
                ),
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
                borderSide: const BorderSide(
                  color: AppColors.gold,
                  width: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CONFIRM PASSPHRASE',
                style: TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              if (_passwordsMatch)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.emerald.withOpacity(0.5),
                      width: 0.8,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, size: 10, color: AppColors.emerald),
                      SizedBox(width: 3),
                      Text(
                        'EXACT MATCH',
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
              hintText: 'Chronos#2024Atelier',
              hintStyle: TextStyle(
                color: AppColors.luxuryMuted.withOpacity(0.55),
                fontSize: 13.5,
              ),
              filled: true,
              fillColor: AppColors.obsidianDark,
              prefixIcon: const Icon(
                Icons.lock_clock_outlined,
                size: 18,
                color: AppColors.gold,
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.luxuryMuted,
                ),
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

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.obsidianDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 4,
        ),
        onPressed: _isLoading ? null : _updatePassphrase,
        child: _isLoading
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
                    'UPDATE PRIVATE SEAL',
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
              content: Text(
                'Connecting to assigned Vendôme Salon concierge liaison...',
              ),
            ),
          );
        },
        child: const Text(
          'Need a dedicated advisor?',
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
