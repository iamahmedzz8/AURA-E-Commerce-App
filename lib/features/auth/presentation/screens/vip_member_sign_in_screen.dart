import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/login_cubit.dart';

class VipMemberSignInScreen extends StatefulWidget {
  const VipMemberSignInScreen({super.key});

  @override
  State<VipMemberSignInScreen> createState() => _VipMemberSignInScreenState();
}

class _VipMemberSignInScreenState extends State<VipMemberSignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passphraseController = TextEditingController();
  bool _rememberMe = true;
  @override
  void initState() {
    super.initState();

    if (PrefsService.rememberMe && PrefsService.savedEmail.isNotEmpty) {
      _idController.text = PrefsService.savedEmail;
      _rememberMe = true;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passphraseController.dispose();
    super.dispose();
  }

  Future<void> _signIn(LoginCubit cubit) async {
    final email = _idController.text.trim();
    final password = _passphraseController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.enterEmailAndPassword)),
      );
      return;
    }

    cubit.login(email: email, password: password);
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
        content: Text(AppStrings.biometricsVerifiedWelcome),
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainScreen()),
      (_) => false,
    );
  }

  void _onForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ForgotPasscodeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = Navigator.of(context).canPop();

    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: Builder(
        builder: (providerContext) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                await PrefsService.setOnboardingCompleted(true);

                await PrefsService.saveLoginSession(
                  email: _rememberMe ? _idController.text.trim() : '',
                  rememberMe: _rememberMe,
                );

                if (!mounted) return;

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => const MainScreen()),
                  (_) => false,
                );
              }

              if (state is LoginFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Scrollable VIP Member Content
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(child: VipAmbientHeader()),
                            SliverToBoxAdapter(
                              child: SegmentedAccessModeSwitch(
                                onTabChanged: (index) {
                                  if (index == 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) =>
                                            const CreateAccountScreen(),
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
                                onEnterSalonTap: () {
                                  _signIn(context.read<LoginCubit>());
                                },
                                onForgotPasswordTap: _onForgotPassword,
                                isLoading: isLoading,
                                onRememberChanged: (value) {
                                  setState(() => _rememberMe = value);
                                },
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
              );
            },
          );
        },
      ),
    );
  }
}
