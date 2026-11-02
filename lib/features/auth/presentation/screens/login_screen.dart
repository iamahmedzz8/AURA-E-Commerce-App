import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:aura_maison_e_commerce/main_screen.dart';
import 'package:flutter/material.dart';

import '../../data/login_data.dart';
import '../widgets/aura_input.dart';
import '../widgets/bag_preview_card.dart';
import '../widgets/face_id_card.dart';
import '../widgets/or_divider.dart';
import '../widgets/section_label.dart';
import '../widgets/social_login_button.dart';
import '../widgets/status_line.dart';
import 'forgot_passcode_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool staySignedIn = true;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    staySignedIn = PrefsService.rememberMe;
    if (PrefsService.rememberMe && PrefsService.savedEmail.isNotEmpty) {
      emailController.text = PrefsService.savedEmail;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and passcode.')),
      );
      return;
    }

    await PrefsService.setOnboardingCompleted(true);
    await PrefsService.saveLoginSession(email: email, rememberMe: staySignedIn);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(),
              const SizedBox(height: 26),
              _securityRow(),
              const SizedBox(height: 28),
              const AuraText(
                '✣  THE ATELIER COLLECTION',
                size: 12,
                weight: FontWeight.w800,
                color: AppColors.orangeDark,
              ),
              const SizedBox(height: 17),
              AuraText('Welcome Back', size: 31, weight: FontWeight.w800),
              const SizedBox(height: 7),
              const AuraText(
                'Sign in to access your curated luxury accessories, private vault, and synchronized shopping bag.',
                size: 15,
                color: AppColors.muted,
              ),
              const SizedBox(height: 25),
              _loginCard(),
              const SizedBox(height: 27),
              const OrDivider(label: 'OR CONTINUE WITH'),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: SocialLoginButton(
                      label: 'Apple ID',
                      dark: true,
                      leading: const Icon(
                        Icons.apple,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SocialLoginButton(
                      label: 'Google',
                      leading: const Text(
                        'G',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const FaceIdCard(),
              const SizedBox(height: 22),
              BagPreviewCard(item: LoginData.bagItem),
              const SizedBox(height: 19),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const AuraText(
                      'New to Aura Accessories? ',
                      size: 13,
                      color: AppColors.muted,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      ),
                      child: const AuraText(
                        'Request Membership',
                        size: 13,
                        color: AppColors.orangeDark,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              const Center(
                child: AuraText(
                  'Terms of Atelier     •     Concierge Privacy     •     Assistance',
                  size: 10,
                  color: AppColors.muted,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      ),
      Row(
        children: [
          Icon(
            Icons.circle,
            size: 24,
            color: Color.fromARGB(255, 255, 253, 253),
          ),
          SizedBox(width: 5),
          AuraText('AURA', size: 21, weight: FontWeight.w800),
        ],
      ),
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: const Icon(Icons.person_outline, color: Colors.white, size: 22),
        ),
      ),
    ],
  );

  Widget _securityRow() => const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(Icons.circle, size: 9, color: AppColors.orange),
          SizedBox(width: 6),
          AuraText(
            'SECURE VAULT ACCESS',
            size: 10,
            weight: FontWeight.w800,
            color: AppColors.muted,
          ),
        ],
      ),
      Row(
        children: [
          Icon(Icons.verified_user_outlined, size: 15, color: AppColors.mint),
          SizedBox(width: 5),
          AuraText(
            '256-BIT SSL',
            size: 10,
            weight: FontWeight.w800,
            color: AppColors.muted,
          ),
        ],
      ),
    ],
  );

  Widget _loginCard() => Container(
    padding: const EdgeInsets.all(17),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 18,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(title: 'Email or Member ID', trailing: 'Required'),
        const SizedBox(height: 9),
        AuraInput(
          hint: 'Email address',
          prefixIcon: Icons.alternate_email,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          suffix: IconButton(
            onPressed: () => emailController.clear(),
            icon: const Icon(
              Icons.cancel_outlined,
              size: 18,
              color: AppColors.muted,
            ),
          ),
        ),
        const SizedBox(height: 9),
        StatusLine(
          icon: Icons.check_circle_outline,
          text: 'Valid Atelier verified member address',
        ),
        const SizedBox(height: 22),
        const SectionLabel(
          title: 'Vault Passcode',
          trailing: 'Min. 8 characters',
        ),
        const SizedBox(height: 9),
        AuraInput(
          hint: 'Vault passcode',
          prefixIcon: Icons.lock_outline,
          controller: passwordController,
          obscureText: !showPassword,
          suffix: IconButton(
            onPressed: () => setState(() => showPassword = !showPassword),
            icon: Icon(
              showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 19,
              color: AppColors.muted,
            ),
          ),
        ),
        const SizedBox(height: 9),
        const StatusLine(
          icon: Icons.shield_outlined,
          text: 'Strong biometric cipher match',
          color: Color(0xFFE8B77F),
          trailing: 'Protected',
        ),
        const SizedBox(height: 17),
        Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: staySignedIn,
                activeColor: AppColors.orange,
                onChanged: (value) =>
                    setState(() => staySignedIn = value ?? false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 7),
            const Expanded(
              child: AuraText('Remember Me', size: 13, color: AppColors.muted),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasscodeScreen(),
                  ),
                );
              },
              child: const AuraText(
                'Forgot Passcode?',
                size: 12,
                color: AppColors.orangeDark,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _signIn,
            icon: const Icon(Icons.lock_outline, size: 19),
            label: const Text(
              'Sign In to Vault',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
