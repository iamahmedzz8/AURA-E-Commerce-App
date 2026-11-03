import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/otp_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/discretion_guarantee_section.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/privilege_registration_form.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/salon_legal_consent_action.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/salon_membership_header.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/widgets/vintage_allocation_card.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: AppStrings.fullNamePlaceholder);
  final TextEditingController _emailController =
      TextEditingController(text: AppStrings.privateEmailPlaceholder);
  final TextEditingController _phoneController =
      TextEditingController(text: AppStrings.mobilePhonePlaceholder);
  final TextEditingController _passwordController =
      TextEditingController(text: AppStrings.securePasswordPlaceholder);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // Seamlessly navigate to OTP Verification preserving app sequence
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => OtpScreen(
          email: email,
          purpose: OtpPurpose.signup,
        ),
      ),
    );
  }

  void _onSignInTap() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const VipMemberSignInScreen(),
        ),
      );
    }
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
              title: AppStrings.createAccountScreenTitle,
              showBackButton: canGoBack,
            ),

            // Scrollable Salon Membership Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Element 1: Application Header & Circle Introduction
                  const SliverToBoxAdapter(
                    child: SalonMembershipHeader(),
                  ),

                  // Element 2: 2025 Vintage Allocation Showcase Card
                  const SliverToBoxAdapter(
                    child: VintageAllocationCard(),
                  ),

                  // Element 3: Privilege Registration Form & Password Criteria
                  SliverToBoxAdapter(
                    child: PrivilegeRegistrationForm(
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      passwordController: _passwordController,
                    ),
                  ),

                  // Element 4: Salon Legal Consent & Application Action Button
                  SliverToBoxAdapter(
                    child: SalonLegalConsentAction(
                      onCreateAccountTap: _onCreateAccount,
                      onPrivacyPolicyTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'AURA MAISON 256-Bit Cryptographic Vault & Privacy Protocol.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Element 5: Salon Member Redirect & Discretion Guarantee
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
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 4),
    );
  }
}
