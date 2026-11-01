

import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:aura_maison_e_commerce/features/auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';


import '../models/validators.dart';
import '../widgets/aura_input.dart';
import '../widgets/custom_auth_button.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_login_button.dart';
import '../widgets/welcome_gift_card.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showConfirm = false;
  bool acceptedTerms = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void createAccount() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate() && acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data is valid. Connect your API here.')),
      );
    } else if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept Terms of Service and Privacy Policy.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 21),
                    SizedBox(width: 5),
                    AuraText('AURA', size: 18, weight: FontWeight.w800),
                  ],
                ),
                const CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            AuraText(
              '✣  THE INNER CIRCLE',
              size: 10,
              weight: FontWeight.w800,
              color: AppColors.orangeDark,
            ),
            const SizedBox(height: 9),
            AuraText('Create Account', size: 25, weight: FontWeight.w800),
            const SizedBox(height: 4),
            AuraText(
              'Join Aura to curate, collect, and experience everyday luxury with bespoke member privileges.',
              size: 11,
              color: AppColors.muted,
            ),
            const SizedBox(height: 14),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Name'),
                  AuraInput(
                    hint: 'e.g. Julian Montgomery',
                    prefixIcon: Icons.person_outline,
                    controller: name,
                    validator: Validators.validateName,
                  ),
                  const SizedBox(height: 10),
                  _label('Email Address'),
                  AuraInput(
                    hint: 'julian@gmail.com',
                    prefixIcon: Icons.mail_outline,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 10),
                  _label('Mobile Phone'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.field,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            '🇪🇬 +20',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AuraInput(
                          hint: 'Phone number',
                          prefixIcon: Icons.call_outlined,
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          validator: Validators.validatePhone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _label('Password', trailing: 'NEEDS 8+ CHARS'),
                  AuraInput(
                    hint: 'At least 8 characters',
                    prefixIcon: Icons.lock_outline,
                    controller: password,
                    obscureText: !showPassword,
                    validator: Validators.validatePassword,
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _label('Confirm Password'),
                  AuraInput(
                    hint: 'Re-enter your password',
                    prefixIcon: Icons.lock_clock_outlined,
                    controller: confirmPassword,
                    obscureText: !showConfirm,
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      password.text,
                    ),
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => showConfirm = !showConfirm),
                      icon: Icon(
                        showConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: acceptedTerms,
                          activeColor: AppColors.orange,
                          onChanged: (v) =>
                              setState(() => acceptedTerms = v ?? false),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: AuraText(
                            'I agree to Aura’s Terms of Service and Privacy Policy.',
                            size: 10,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CustomAuthButton(
                    title: 'Create Account',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(email: email.text),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const OrDivider(label: 'OR FAST TRACK WITH'),
            const SizedBox(height: 13),
            Row(
              children: [
                Expanded(
                  child: SocialLoginButton(
                    label: 'Apple',
                    leading: const Icon(
                      Icons.apple,
                      size: 19,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: SocialLoginButton(
                    label: 'Google',
                    leading: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const WelcomeGiftCard(),
            const SizedBox(height: 19),
            Center(
              child: Wrap(
                children: [
                  const AuraText(
                    'Already have an account? ',
                    size: 11,
                    color: AppColors.muted,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const AuraText(
                      'Sign In',
                      size: 11,
                      color: AppColors.orangeDark,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _label(String title, {String? trailing}) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuraText(title, size: 10, weight: FontWeight.w700),
        if (trailing != null)
          AuraText(
            trailing,
            size: 8,
            weight: FontWeight.w700,
            color: AppColors.muted,
          ),
      ],
    ),
  );
}
