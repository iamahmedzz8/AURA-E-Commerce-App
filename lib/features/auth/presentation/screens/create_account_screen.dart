
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/auth/data/models/register_model.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/register_cubit.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/register_state.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/otp_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/discretion_guarantee_section.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/privilege_registration_form.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/salon_legal_consent_action.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/salon_membership_header.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/vintage_allocation_card.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/screens/police_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late RegisterCubit _registerCubit;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    _registerCubit = RegisterCubit();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _registerCubit.close();

    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onCreateAccount() async {
    FocusScope.of(context).unfocus();

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // 1) Required fields
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      _showMessage(AppStrings.fillAllRequiredFields);
      return;
    }

    // 2) Email
    if (!_emailRegex.hasMatch(email)) {
      _showMessage(AppStrings.enterValidEmailAddress);
      return;
    }

    // 3) Password rules
    if (!PasswordRules.isValid(password)) {
      _showMessage(AppStrings.passwordRulesPrompt);
      return;
    }

    final registerModel = RegisterModel(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    _registerCubit.register(registerModel);
  }

  void _onSignInTap() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => VipMemberSignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerCubit,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            _showMessage(AppStrings.accountCreatedSuccess);

            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => OtpScreen(
                  email: state.email,
                  purpose: OtpPurpose.signup,
                ),
              ),
            );
          }

          if (state is RegisterFailure) {
            _showMessage(state.msg);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is RegisterLoading;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Fixed App Header
                      // AppHeader(
                      //   title: AppStrings.createAccountScreenTitle,
                      //   showBackButton: canGoBack,
                      // ),

                      // Scrollable Salon Membership Content
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            // Element 1: Application Header
                            SliverToBoxAdapter(
                              child: SalonMembershipHeader(),
                            ),

                            // Element 2: Vintage Allocation Card
                            SliverToBoxAdapter(
                              child: VintageAllocationCard(),
                            ),

                            // Element 3: Registration Form
                            SliverToBoxAdapter(
                              child: PrivilegeRegistrationForm(
                                firstNameController: _firstNameController,
                                lastNameController: _lastNameController,
                                emailController: _emailController,
                                phoneController: _phoneController,
                                passwordController: _passwordController,
                              ),
                            ),

                            // Element 4: Legal Consent & Registration Button
                            SliverToBoxAdapter(
                              child: SalonLegalConsentAction(
                                onCreateAccountTap: _onCreateAccount,
                                onPrivacyPolicyTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyPolicyScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Element 5: Sign In & Discretion Guarantee
                            SliverToBoxAdapter(
                              child: DiscretionGuaranteeSection(
                                onSignInTap: _onSignInTap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Loading overlay
                  if (isLoading)
                    Positioned.fill(
                      child: AbsorbPointer(
                        child: Container(
                          color: Colors.black54,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.goldAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // bottomNavigationBar: AppBottomNavBar(currentIndex: 4),
          );
        },
      ),
    );
  }
}
