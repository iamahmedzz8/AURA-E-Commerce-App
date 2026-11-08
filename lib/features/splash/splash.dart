/// Splash Feature Module — barrel export
/// Covers: Splash, Onboarding (3 steps), Private Concierge (filterable)
/// Internal models, data, and widgets live here and only talk to each other.
// library;

// export 'screens/splash_salon_screen.dart';
// export 'screens/onboarding_screen.dart';
// export 'screens/private_concierge_screen.dart';
// export 'models/concierge_service_model.dart';
// export 'models/advisor_model.dart';
// export 'models/service_filter_model.dart';
// export 'data/concierge_data.dart';
// export 'widgets/advisor_card.dart';
// export 'widgets/concierge_filter_bar.dart';
// export 'widgets/concierge_service_card.dart';
// export 'widgets/salon_header.dart';
// export 'widgets/confidentiality_pill.dart';
// export 'widgets/salon_vitrine_card.dart';
// export 'widgets/salon_central_sanctuary.dart';
// export 'widgets/salon_entrance_portal.dart';
// export 'widgets/chapter_tag.dart';
// export 'widgets/pillar_tile.dart';
// export 'widgets/centerpiece_card.dart';
// export 'widgets/onboarding_service_item.dart';
// export 'widgets/aura_gold_button.dart';
// export 'widgets/discreet_guarantee_text.dart';
// export 'widgets/onboarding_top_nav.dart';
// export 'widgets/assigned_advisor_card.dart';
// export 'widgets/concierge_top_bar.dart';
// export 'widgets/concierge_editorial_header.dart';
// export 'cubit/splash_cubit.dart';
// export 'cubit/onboarding_cubit.dart';
// export 'cubit/concierge_cubit.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({
    super.key,
    required this.nextBuilder,
    this.duration = const Duration(milliseconds: 2800),
  });

  /// الشاشة اللي هينتقل لها بعد الـ splash (onboarding أو login...)
  final WidgetBuilder nextBuilder;
  final Duration duration;

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  static const _bg = Color(0xFF080B10);
  static const _gold = Color(0xFFC5A059);

  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _textFade;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _timer = Timer(widget.duration, _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, _, __) => widget.nextBuilder(context),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.0,
            colors: [Color(0xFF20242B), _bg],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Image.asset(
                    'assets/images/logos/icon_foreground (1).png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeTransition(
                opacity: _textFade,
                child: Column(
                  children: [
                    const Text(
                      'AURA MAISON',
                      style: TextStyle(
                        color: _gold,
                        fontSize: 26,
                        letterSpacing: 6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 48,
                      height: 1.5,
                      color: _gold.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'LUXURY ACCESSORIES',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 11,
                        letterSpacing: 4,
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
  }
}