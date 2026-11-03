import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/create_account_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/forgot_passcode_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/biometric_access_section.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/discreet_provenance_footer.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/patron_authentication_form.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/segmented_access_mode_switch.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/vip_ambient_header.dart';
import 'package:aura_maison_e_commerce/main_screen.dart';
import 'package:flutter/material.dart';

class VipMemberSignInScreen extends StatefulWidget {
  const VipMemberSignInScreen({super.key});

  @override
  State<VipMemberSignInScreen> createState() => _VipMemberSignInScreenState();
}

class _VipMemberSignInScreenState extends State<VipMemberSignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passphraseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (PrefsService.rememberMe && PrefsService.savedEmail.isNotEmpty) {
      _idController.text = PrefsService.savedEmail;
    } else {
      _idController.text = AppStrings.patronIdPlaceholder;
    }
    _passphraseController.text = AppStrings.passphrasePlaceholder;
  }

  @override
  void dispose() {
    _idController.dispose();
    _passphraseController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final emailOrId = _idController.text.trim();
    final passphrase = _passphraseController.text;

    if (emailOrId.isEmpty || passphrase.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your Patron ID and workshop passphrase.'),
        ),
      );
      return;
    }

    await PrefsService.setOnboardingCompleted(true);
    await PrefsService.saveLoginSession(
      email: emailOrId,
      rememberMe: true,
    );

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainScreen()),
      (_) => false,
    );
  }

  Future<void> _onBiometricSignIn() async {
    await PrefsService.setOnboardingCompleted(true);
    await PrefsService.saveLoginSession(
      email: _idController.text.trim().isNotEmpty
          ? _idController.text.trim()
          : AppStrings.patronIdPlaceholder,
      rememberMe: true,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vault Biometrics Verified. Welcome, Patron.'),
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainScreen()),
      (_) => false,
    );
  }

  void _onForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ForgotPasscodeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Fixed App Header
            AppHeader(
              title: AppStrings.vipMemberScreenTitle,
              showBackButton: canGoBack,
            ),

            // Scrollable VIP Member Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: VipAmbientHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: SegmentedAccessModeSwitch(
                      onTabChanged: (index) {
                        if (index == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const CreateAccountScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PatronAuthenticationForm(
                      idController: _idController,
                      passphraseController: _passphraseController,
                      onEnterSalonTap: _signIn,
                      onForgotPasswordTap: _onForgotPassword,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BiometricAccessSection(
                      onBiometricTap: _onBiometricSignIn,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: DiscreetProvenanceFooter(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
    );
  }
}
