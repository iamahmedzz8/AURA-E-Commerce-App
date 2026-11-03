import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/create_account_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/assigned_advisor_card.dart';
import '../widgets/aura_gold_button.dart';
import '../widgets/centerpiece_card.dart';
import '../widgets/chapter_tag.dart';
import '../widgets/discreet_guarantee_text.dart';
import '../widgets/onboarding_service_item.dart';
import '../widgets/onboarding_top_nav.dart';
import '../widgets/pillar_tile.dart';
import 'private_concierge_screen.dart';

/// 3-Step Guided Onboarding Screen (Nodes 1:141, 1:226, 1:332)
/// Pillar I: Fine Watchmaking, Pillar II: Vault Sanctuary, Pillar III: Private Concierge
class OnboardingScreen extends StatefulWidget {
  final int initialStep;
  const OnboardingScreen({super.key, this.initialStep = 0});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
    _pageController = PageController(initialPage: widget.initialStep);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step >= 0 && step <= 2) {
      _pageController.animateToPage(
        step,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    await PrefsService.setOnboardingCompleted(true);
  }

  Future<void> _skipToAuth() async {
    await _completeOnboarding();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const VipMemberSignInScreen()),
    );
  }

  Future<void> _goToSignup() async {
    await _completeOnboarding();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateAccountScreen()),
    );
  }

  Future<void> _goToLogin() async {
    await _completeOnboarding();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VipMemberSignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingTopNav(currentStep: _currentStep, onSkip: _skipToAuth),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (idx) {
                  setState(() => _currentStep = idx);
                },
                children: [
                  _buildWatchmakingStep(),
                  _buildVaultSanctuaryStep(),
                  _buildPrivateConciergeStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // STEP 1: FINE WATCHMAKING
  // ==========================================
  Widget _buildWatchmakingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChapterTag('PILLAR I • SWISS MANUFACTURE'),
          const SizedBox(height: 12),
          const Text(
            'The Excellence of\nPerpetual Time',
            style: TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 34,
              fontWeight: FontWeight.w400,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Discover rare timepieces and exceptional complications, hand-assembled in the centuries-old workshops of Genève and Vallée de Joux.',
            style: TextStyle(
              color: AppColors.ivoryMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          const PillarTile(
            title: 'In-House Calibres',
            subtitle: 'IN-HOUSE MECHANICAL MOVEMENTS',
            badge: '3Hz / 4Hz',
            icon: Icons.settings_suggest_outlined,
          ),
          const SizedBox(height: 10),
          const PillarTile(
            title: 'Rare Complications',
            subtitle: 'TOURBILLONS & PERPETUAL CALENDARS',
            badge: 'Master',
            icon: Icons.all_inclusive,
          ),
          const SizedBox(height: 10),
          const PillarTile(
            title: 'Geneva Seal Hand Finishing',
            subtitle: 'BEVELING, CIRCULAR GRAINING & STRIPES',
            badge: '100% Handmade',
            icon: Icons.handyman_outlined,
          ),
          const SizedBox(height: 22),
          const CenterpieceCard(
            workshopTag: 'WORKSHOP N° 04 • GENÈVE',
            quote: '“Time respects nothing that is made without it.”',
            icon: Icons.watch_outlined,
          ),
          const SizedBox(height: 22),
          AuraGoldButton(
            label: 'CONTINUE EXPLORING',
            onTap: () => _goToStep(1),
          ),
          const SizedBox(height: 14),
          const DiscreetGuaranteeText(),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 2: VAULT SANCTUARY
  // ==========================================
  Widget _buildVaultSanctuaryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChapterTag('PILLAR II • CUSTODY & SECURITY'),
          const SizedBox(height: 12),
          const Text(
            'Your Digital &\nPhysical Vault',
            style: TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 34,
              fontWeight: FontWeight.w400,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Every acquired masterpiece receives secure custody in a Swiss bonded vault, with a tamper-proof digital certificate of authenticity.',
            style: TextStyle(
              color: AppColors.ivoryMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          const PillarTile(
            title: 'Secure Custody in Switzerland',
            subtitle: 'High-security bonded facilities',
            badge: 'ISO 27001',
            icon: Icons.account_balance_outlined,
          ),
          const SizedBox(height: 10),
          const PillarTile(
            title: 'Digital Certificate of Origin',
            subtitle: 'Immutable cryptographic fingerprint',
            badge: 'VERIFIED',
            icon: Icons.verified_user_outlined,
          ),
          const SizedBox(height: 10),
          const PillarTile(
            title: 'Tier-1 All-Risk Insurance',
            subtitle: 'Underwritten by Lloyd’s syndicates',
            badge: '100% VALUE',
            icon: Icons.security_outlined,
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.obsidianCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'GENÈVE FREEPORT • SECURE',
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'LAT: 46°12′N • LON: 06°09′E',
                      style: TextStyle(
                        color: AppColors.luxuryMuted,
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.obsidianDark,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Text(
                    'AES-256 HSM',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.gold,
                    side: const BorderSide(color: AppColors.gold, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () => _goToStep(0),
                  child: const Text(
                    'PREVIOUS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: AuraGoldButton(
                  label: 'CONTINUE',
                  onTap: () => _goToStep(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const DiscreetGuaranteeText(),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 3: PRIVATE CONCIERGE & ONBOARDING FINAL
  // ==========================================
  Widget _buildPrivateConciergeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.7),
                      width: 1.2,
                    ),
                    color: AppColors.obsidianDark,
                  ),
                  child: const Center(
                    child: Text(
                      'AM',
                      style: TextStyle(
                        fontFamily: 'serif',
                        color: AppColors.gold,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'AURA MAISON • PLACE VENDÔME',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const ChapterTag('PILLAR III • BESPOKE SERVICE'),
          const SizedBox(height: 12),
          const Text(
            'Confidential\nGuidance',
            style: TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 32,
              fontWeight: FontWeight.w400,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your dedicated private advisor arranges private viewings at home or in a discreet salon, with secure personal handover.',
            style: TextStyle(
              color: AppColors.ivoryMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const AssignedAdvisorCard(),
          const SizedBox(height: 18),
          const Text(
            'EXCLUSIVE SERVICES INCLUDED',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const OnboardingServiceItem(
            title: 'Dedicated Advisor 24/7',
            tag: 'Direct Line',
            description:
                'An exclusive encrypted channel to commission your watch acquisitions and unique pieces at any time.',
          ),
          const SizedBox(height: 10),
          const OnboardingServiceItem(
            title: 'Secure Personal Delivery',
            tag: 'Private Escort',
            description:
                'Armed couriers and tamper-proof seals for discreet handover at your residence or hotel suite.',
          ),
          const SizedBox(height: 10),
          const OnboardingServiceItem(
            title: 'International Private Salon Access',
            tag: 'Worldwide',
            description:
                'Priority booking at our private salons in Paris, Zurich, New York, Tokyo and Dubaï.',
          ),
          const SizedBox(height: 14),
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivateConciergeScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.tune, size: 14, color: AppColors.gold),
              label: const Text(
                'FILTER & EXPLORE ALL PRIVILEGES',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AuraGoldButton(
            label: 'CREATE A PRIVILEGE ACCOUNT',
            onTap: _goToSignup,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.ivory,
                side: const BorderSide(color: AppColors.gold, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: _goToLogin,
              child: const Text(
                'ALREADY A MEMBER? SIGN IN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'CONFIDENTIAL ACCREDITATION COMPLIANT WITH FINE WATCHMAKING',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.luxuryMuted,
                fontSize: 9,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
