import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/aura_medallion_header.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/concierge_support_badge.dart';
import '../widgets/instruction_protocol_card.dart';
import 'otp_screen.dart';

/// Forgot Passcode / Access Key Recovery Screen (Node 6:238)
/// High-security protocol for resetting member access key or vault passcode.
/// TODO: Connect [sendRecoveryLink] to your backend API via [ForgotPasscodeCubit].
class ForgotPasscodeScreen extends StatefulWidget {
  const ForgotPasscodeScreen({super.key});

  @override
  State<ForgotPasscodeScreen> createState() => _ForgotPasscodeScreenState();
}

class _ForgotPasscodeScreenState extends State<ForgotPasscodeScreen> {
  final _identifierController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _sendRecoveryLink() {
    FocusScope.of(context).unfocus();
    final value = _identifierController.text.trim();

    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your member email or patron vault ID.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulated dispatch (connect API in ForgotPasscodeCubit)
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.obsidianElevated,
          content: Text(
            'Secure recovery dispatch sent to $value.',
            style: const TextStyle(color: AppColors.ivory),
          ),
          action: SnackBarAction(
            label: 'ENTER OTP',
            textColor: AppColors.gold,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    email: value,
                    purpose: OtpPurpose.resetPassword,
                  ),
                ),
              );
            },
          ),
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
              title: 'Forgot Password',
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuraMedallionHeader(
                        icon: Icons.vpn_key_outlined,
                        tag: 'HIGH-SECURITY PROTOCOL',
                        title: 'Private Seal Recovery',
                        subtitle:
                            'Enter your member email address\nor vault ID to reset your access key.',
                      ),
                      const SizedBox(height: 24),
                      _buildInputVitrineCard(),
                      const SizedBox(height: 14),
                      const InstructionProtocolCard(
                        title: 'ESCROW DURATION',
                        description:
                            'A single-use link valid for 15 minutes will be sent via an encrypted protocol.',
                      ),
                      const SizedBox(height: 20),
                      _buildActionButton(),
                      const SizedBox(height: 18),
                      _buildReturnToLogin(context),
                      const SizedBox(height: 24),
                      const ConciergeSupportBadge(),
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

  Widget _buildInputVitrineCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
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
                'PRIVATE EMAIL OR PATRON ID',
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
                    color: AppColors.gold.withValues(alpha: 0.3),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  'Vault 4096-bit',
                  style: TextStyle(
                    color: AppColors.gold.withValues(alpha: 0.8),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _identifierController,
            style: const TextStyle(
              color: AppColors.ivory,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'patron@vendome-sanctuary.ch',
              hintStyle: TextStyle(
                color: AppColors.luxuryMuted.withValues(alpha: 0.6),
                fontSize: 13.5,
              ),
              filled: true,
              fillColor: AppColors.obsidianDark,
              prefixIcon: const Icon(
                Icons.alternate_email,
                size: 18,
                color: AppColors.gold,
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
        onPressed: _isLoading ? null : _sendRecoveryLink,
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
                    'SEND RECOVERY LINK',
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

  Widget _buildReturnToLogin(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(
          Icons.arrow_back,
          size: 15,
          color: AppColors.luxuryMuted,
        ),
        label: const Text(
          'Return to Salon Sign-In',
          style: TextStyle(
            color: AppColors.luxuryMuted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
