import 'dart:async';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/resendotp.dart';
import 'package:aura_maison_e_commerce/features/auth/data/datasources/verify_email.dart';
import 'package:aura_maison_e_commerce/features/auth/data/models/verify_model.dart';
import 'package:aura_maison_e_commerce/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/aura_medallion_header.dart';
import '../widgets/auth_info_row.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/encryption_footer_note.dart';
import '../widgets/session_security_banner.dart';
import 'reset_password_screen.dart';

export '../cubit/otp_cubit.dart' show OtpPurpose;

class OtpScreen extends StatefulWidget {
  final String email;
  final OtpPurpose purpose;

  const OtpScreen({
    super.key,
    required this.email,
    this.purpose = OtpPurpose.resetPassword,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _initialSeconds = 49;

  final _controllers = List.generate(6, (_) => TextEditingController());
  final _nodes = List.generate(6, (_) => FocusNode());

  final VerifyEmailService _verifyService = VerifyEmailService();
  final ResendOtpService _resendService = ResendOtpService();

  Timer? _timer;
  int _seconds = 59;
  int _seconds = _initialSeconds;
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = _initialSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_seconds <= 1) {
        t.cancel();
        setState(() => _seconds = 0);
      } else {
        if (mounted) {
          setState(() => _seconds--);
        }
      }
    });
  }

  void _resend(BuildContext context) {
    if (_seconds != 0) return;
    context.read<OtpCubit>().resendOtp(widget.email);
  }

  void _verify(BuildContext context) {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.obsidianElevated,
          content: Text(
            'Please enter all 6 digits of the security code.',
            style: TextStyle(color: AppColors.ivory),
          ),
        ),
      );
      return;
    }

    context.read<OtpCubit>().verifyOtp(
          email: widget.email,
          otp: code,
          purpose: widget.purpose,
        );
  Future<void> _resend() async {
    if (_seconds != 0 || _isResending) return;

    setState(() => _isResending = true);

    try {
      // For signup, ask the server to send a new code.
      if (widget.purpose == OtpPurpose.signup) {
        await _resendService.resend(widget.email);
      }

      if (!mounted) return;

      for (final c in _controllers) {
        c.clear();
      }
      _startTimer();
      _nodes.first.requestFocus();
      _showMessage('Dispatched new security code via relay.');
    } catch (e) {
      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _verify() async {
    if (_isVerifying) return;

    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      _showMessage('Please enter all 6 digits.');
      return;
    }

    if (widget.purpose == OtpPurpose.signup) {
      FocusScope.of(context).unfocus();
      setState(() => _isVerifying = true);

      try {
        await _verifyService.verifyEmail(
          VerifyEmailModel(email: widget.email, otp: code),
        );

        await PrefsService.setOnboardingCompleted(true);
        await PrefsService.saveLoginSession(
          email: widget.email,
          rememberMe: true,
        );

        if (!mounted) return;
        _showMessage('Account verified. Welcome to Aura.');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (_) => false,
        );
      } catch (e) {
        _showMessage(e.toString().replaceFirst('Exception: ', ''));
      } finally {
        if (mounted) setState(() => _isVerifying = false);
      }
      return;
    }

    _showMessage('Verification successful. Proceeding to set new seal...');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(email: widget.email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpCubit>(
      create: (_) => sl<OtpCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.obsidianDark,
        body: SafeArea(
          child: BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) async {
              if (state is OtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.obsidianElevated,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
              } else if (state is OtpResendFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.obsidianElevated,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
              } else if (state is OtpResendSuccess) {
                for (final c in _controllers) {
                  c.clear();
                }
                setState(() => _seconds = 59);
                _startTimer();
                _nodes.first.requestFocus();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.obsidianElevated,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: AppColors.ivory),
                    ),
                  ),
                );
              } else if (state is OtpSuccess) {
                if (state.purpose == OtpPurpose.signup) {
                  await PrefsService.setOnboardingCompleted(true);
                  await PrefsService.saveLoginSession(
                    email: state.email,
                    rememberMe: true,
                  );

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.obsidianElevated,
                      content: Text(
                        'Account verified. Welcome to Aura Maison.',
                        style: TextStyle(color: AppColors.ivory),
                      ),
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (_) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.obsidianElevated,
                      content: Text(
                        'Security code confirmed. Proceeding to set new seal...',
                        style: TextStyle(color: AppColors.ivory),
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResetPasswordScreen(
                        email: state.email,
                        otp: state.otp,
                      ),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              final isVerifying = state is OtpLoading;
              final isResending = state is OtpResendLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTopBar(
                      title: 'Otp Verification',
                      onBack: () => Navigator.pop(context),
                      backIcon: Icons.arrow_back,
                    ),
                    const SizedBox(height: 24),
                    AuraMedallionHeader(
                      icon: Icons.lock,
                      tag: 'CONCIERGE PROTOCOL',
                      title: 'Private Security Code',
                      subtitle:
                          'An exclusive six-digit confirmation\ncode has been sent to',
                      extraChild: Text(
                        widget.email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.ivory,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SessionSecurityBanner(),
                    const SizedBox(height: 24),
                    _buildOtpInputBoxes(),
                    const SizedBox(height: 18),
                    _buildTimerAndResend(context, isResending),
                    const SizedBox(height: 22),
                    _buildVerifyButton(context, isVerifying),
                    const SizedBox(height: 12),
                    _buildChangeAuthButton(),
                    const SizedBox(height: 24),
                    _buildWorkspaceInfoCard(),
                    const SizedBox(height: 18),
                    const EncryptionFooterNote(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputBoxes() {
    return Row(
      children: List.generate(
        6,
        (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == 5 ? 0 : 6),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: _controllers[i],
                focusNode: _nodes[i],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                  color: AppColors.ivory,
                  fontSize: 22,
                  fontFamily: 'serif',
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.obsidianElevated,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: AppColors.gold,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (v) {
                  if (v.isNotEmpty && i < 5) _nodes[i + 1].requestFocus();
                  if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerAndResend(BuildContext context, bool isResending) {
  Widget _buildTimerAndResend() {
    final bool canResend = _seconds == 0 && !_isResending;

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_bottom,
                color: AppColors.gold,
                size: 16,
              ),
              const SizedBox(width: 7),
              Text(
                'Expires in 00:${_seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: AppColors.ivoryMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (isResending)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.gold,
                ),
              ),
            )
          else
            TextButton(
              onPressed: _seconds == 0 ? () => _resend(context) : null,
              child: Text(
                'ISSUE A NEW CODE',
                style: TextStyle(
                  color: _seconds == 0
                      ? AppColors.gold
                      : AppColors.obsidianBorder,
                  letterSpacing: 1.1,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
          TextButton(
            onPressed: canResend ? _resend : null,
            child: Text(
              'ISSUE A NEW CODE',
              style: TextStyle(
                color: canResend ? AppColors.gold : AppColors.obsidianBorder,
                letterSpacing: 1.1,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context, bool isVerifying) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: isVerifying ? null : () => _verify(context),
        icon: isVerifying
            ? const SizedBox(
                width: 18,
                height: 18,
        onPressed: _isVerifying ? null : _verify,
        icon: _isVerifying
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.obsidianDark,
                ),
              )
            : const Icon(Icons.arrow_forward, size: 17),
        label: Text(
          isVerifying ? 'AUTHENTICATING...' : 'VERIFY AURA ACCESS',
          style: const TextStyle(
        label: const Text(
          'VERIFY AURA ACCESS',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w800,
            fontSize: 11,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.obsidianDark,
          disabledBackgroundColor: AppColors.gold,
          disabledForegroundColor: AppColors.obsidianDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _buildChangeAuthButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, size: 16),
        label: const Text(
          'CHANGE AUTHENTICATION',
          style: TextStyle(
            letterSpacing: 1.1,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ivoryMuted,
          backgroundColor: AppColors.obsidianCard,
          side: const BorderSide(color: AppColors.obsidianBorder),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _buildWorkspaceInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.obsidianBorder, width: 0.8),
      ),
      child: const Column(
        children: [
          AuthInfoRow(
            label: 'ASSIGNED WORKSPACE',
            value: 'Paris Fine Watchmaking Salon',
          ),
          SizedBox(height: 12),
          AuthInfoRow(
            label: 'DELIVERY CHANNEL',
            value: 'Secure Messaging Relay',
          ),
          SizedBox(height: 12),
          AuthInfoRow(
            label: 'BATCH ID',
            value: 'W.R. - 0021-CH',
            valueColor: AppColors.gold,
          ),
        ],
      ),
    );
  }
}