import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/offer_model.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/screens/product_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import '../../../products/products/presentation/screens/products_screen.dart';
import 'package:aura_maison_e_commerce/core/theme/theme_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<OffersCubit>(
          create: (_) => sl<OffersCubit>()..fetchOffers(),
        ),
      ],
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final PageController _offerPageController = PageController();
  int _currentOfferPage = 0;

  @override
  void dispose() {
    _offerPageController.dispose();
    super.dispose();
  }

  bool get isDark => context.watch<ThemeCubit>().state == ThemeMode.dark;
  int get selectedTab => context.read<HomeCubit>().state.selectedTab;
  Set<int> get favorites => context.read<HomeCubit>().state.favorites;

  static const Color gold = Color(0xFFC5A059);
  static const Color darkBackground = Color(0xFF080B10);
  static const Color darkSurface = Color(0xFF191C21);
  static const Color lightBackground = Color(0xFFFBF9F5);
  static const Color lightSurface = Colors.white;

  Color get background => isDark ? darkBackground : lightBackground;
  Color get surface => isDark ? darkSurface : lightSurface;
  Color get foreground =>
      isDark ? Colors.white : const Color(0xFF171717);
  Color get muted =>
      isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  static const List<Map<String, String>> products = [
    {
      'name': 'Royal Tourbillon',
      'category': 'WATCHMAKING HOUSE',
      'price': '\$124,500',
      'description': 'Skeleton 950 Platinum',
      'rating': '—',
      'image':
          'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=700',
      'tag': 'ONE OF A KIND',
    },
    {
      'name': 'Star Solitaire',
      'category': 'HIGH JEWELRY',
      'price': '\$88,000',
      'description': '4.2ct D/FL Flawless',
      'rating': '—',
      'image':
          'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=700',
      'tag': 'GIA CERTIFIED',
    },
    {
      'name': 'Vendome Matte Black',
      'category': 'LEATHER GOODS',
      'price': '\$16,800',
      'description': 'Croc-Embossed Leather',
      'rating': '—',
      'image':
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=700',
      'tag': 'MAISON HOME',
    },
    {
      'name': 'Eclipse Aviator',
      'category': 'EYEWEAR',
      'price': '\$3,400',
      'description': '18k Gold • Mineral Glass Lenses',
      'rating': '—',
      'image':
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=700',
      'tag': 'PRIVATE EYEWEAR',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: header()),
                SliverToBoxAdapter(child: hero()),
                SliverToBoxAdapter(child: invitation()),
                SliverToBoxAdapter(child: disciplines()),
                SliverToBoxAdapter(
                  child: sectionHeader(
                    title: 'Featured Masterpieces',
                    action: 'VIEW ALL',
                    onTap: openProducts,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => productCard(index),
                      childCount: products.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 14,
                      childAspectRatio: .62,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: sectionHeader(
                    title: 'Discover the House',
                    action: 'EXPLORE',
                    onTap: openProducts,
                  ),
                ),
                SliverToBoxAdapter(child: editorial()),
                SliverToBoxAdapter(child: concierge()),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductsScreen(),
      ),
    );
  }

  Widget header() {
    return Container(
      color: isDark ? darkBackground : const Color(0xFF101216),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: SizedBox(
        height: 42,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'AURA MAISON',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.8,
                ),
              ),
            ),
            const Center(
              child: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'EB Garamond',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: openProducts,
                    visualDensity: VisualDensity.compact,
                    icon:
                        const Icon(Icons.search, color: Colors.white, size: 21),
                  ),
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: gold,
                      size: 21,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.read<HomeCubit>().changeTab(4),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: gold,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Color(0xFF171717),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hero() {
    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        if (state is OffersLoadingState) {
          return _buildHeroLoading();
        }

        if (state is OffersFailureState) {
          return _buildHeroError(state.errorMessage);
        }

        if (state is OffersSuccessState) {
          if (state.offers.isEmpty) {
            return _buildDefaultHeroCard();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 390,
                child: PageView.builder(
                  controller: _offerPageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentOfferPage = index);
                  },
                  itemCount: state.offers.length,
                  itemBuilder: (context, index) {
                    final offer = state.offers[index];
                    return _buildOfferHeroCard(offer);
                  },
                ),
              ),
              if (state.offers.length > 1) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(state.offers.length, (i) {
                    final isSelected = i == _currentOfferPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isSelected ? 20 : 6,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? gold
                            : (isDark
                                ? Colors.white.withValues(alpha: .2)
                                : Colors.black.withValues(alpha: .2)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),
              ],
            ],
          );
        }

        return _buildDefaultHeroCard();
      },
    );
  }

  Widget _buildOfferHeroCard(OfferModel offer) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (offer.coverUrl.isNotEmpty)
            Image.network(
              offer.coverUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: darkSurface,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white24,
                      size: 40,
                    ),
                  ),
                );
              },
            )
          else
            Container(color: darkSurface),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .1),
                  Colors.black.withValues(alpha: .35),
                  Colors.black.withValues(alpha: .94),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  color: Colors.black.withValues(alpha: .6),
                  child: const Text(
                    '● EXCLUSIVE MAISON OFFER',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: gold,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'SPECIAL PROMOTION',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: gold,
                    fontSize: 10,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  offer.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'EB Garamond',
                    color: Colors.white,
                    fontSize: 28,
                    height: 1.05,
                  ),
                ),
                if (offer.description != null &&
                    offer.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    offer.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white70,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURATION',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white60,
                              fontSize: 8,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'LIMITED PRIVILEGE',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: openProducts,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'EXPLORE\nOFFER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .8,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 13),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroLoading() {
    return Container(
      height: 390,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: gold,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'CURATING OFFERS...',
              style: TextStyle(
                fontFamily: 'Inter',
                color: muted,
                fontSize: 10,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroError(String message) {
    return Container(
      height: 390,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: gold, size: 32),
            const SizedBox(height: 12),
            Text(
              message.isNotEmpty ? message : 'Failed to load offers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                color: foreground,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.read<OffersCubit>().fetchOffers(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: gold),
                foregroundColor: gold,
              ),
              child: const Text('RETRY'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultHeroCard() {
    return Container(
      height: 390,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=1200',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: darkSurface);
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .08),
                  Colors.black.withValues(alpha: .25),
                  Colors.black.withValues(alpha: .92),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  color: Colors.black.withValues(alpha: .55),
                  child: const Text(
                    '● LIMITED EDITION • 25 PIECES',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: gold,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'FINE WATCHMAKING Nº 07',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: gold,
                    fontSize: 10,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Imperial\nChronograph',
                  style: TextStyle(
                    fontFamily: 'EB Garamond',
                    color: Colors.white,
                    fontSize: 31,
                    height: 1.02,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'In-house hand-wound skeleton calibre\nwith silicon escapement and case in...',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white70,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WORKSHOP PRICE',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white60,
                              fontSize: 8,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '\$210,000',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: openProducts,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ACQUIRE\nALLOCATION',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .7,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget invitation() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: gold.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.diamond_outlined,
              color: gold,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'PRIVATE INVITATION',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: gold,
                        fontSize: 9,
                        letterSpacing: .8,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'VIP SALON',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: gold,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Genève Watches & Wonders Preview',
                  style: TextStyle(
                    fontFamily: 'EB Garamond',
                    color: foreground,
                    fontSize: 17,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Private access before public opening. Book your session with our master...',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: muted,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'REQUEST ACCESS',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: gold,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.north_east_rounded,
                      color: gold,
                      size: 14,
                    ),
                    const Spacer(),
                    Text(
                      '14 Places left',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: muted,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget disciplines() {
    final items = [
      (
        'WATCHMAKING',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=500'
      ),
      (
        'HIGH JEWELRY',
        'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500'
      ),
      (
        'LEATHER GOODS',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'
      ),
      (
        'EYEWEAR',
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(
          title: 'Curated Disciplines',
          action: 'ARCHIVES',
          onTap: openProducts,
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: openProducts,
                child: Container(
                  width: 88,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        items[index].$2,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(color: darkSurface);
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: .8),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            items[index].$1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget sectionHeader({
    required String title,
    required String action,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'EB Garamond',
                color: foreground,
                fontSize: 22,
                height: 1.1,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: gold,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .8,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.north_east_rounded,
                  color: gold,
                  size: 13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(int index) {
    final item = products[index];
    final isFavorite = favorites.contains(index);

    return GestureDetector(
      onTap: () => openProductDetails(item),
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: darkSurface,
                      child: const Icon(
                        Icons.watch_outlined,
                        color: gold,
                        size: 45,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () =>
                          context.read<HomeCubit>().toggleFavorite(index),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xCC292D33)
                              : Colors.white.withValues(alpha: .92),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: isFavorite ? gold : foreground,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .72),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        item['tag']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: gold,
                          fontSize: 8,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['category']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: gold,
                        fontSize: 8,
                        letterSpacing: .6,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['name']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'EB Garamond',
                        color: foreground,
                        fontSize: 16,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['description']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: muted,
                        fontSize: 10,
                        height: 1.25,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['price']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: foreground,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF292D33)
                                : const Color(0xFFF0EEE9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () => showAddedToBag(item),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.shopping_bag_outlined,
                              color: foreground,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openProductDetails(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: item),
      ),
    );
  }

  void showAddedToBag(Map<String, String> item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item['name']} added to bag'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Widget editorial() {
    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=1200',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(color: darkSurface);
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: .85),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'SPECIAL ORDER',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: gold,
                    fontSize: 9,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Celeste Orrery\nPerpetual Motion',
                  style: TextStyle(
                    fontFamily: 'EB Garamond',
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Automatic celestial artistry in motion.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: openProducts,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 13,
                  ),
                  label: const Text(
                    'VIEW THE STUDY',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 9,
                      letterSpacing: .8,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white54,
                      width: .7,
                    ),
                    shape: const RoundedRectangleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget concierge() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: gold.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: gold,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRIVATE CONCIERGE',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: gold,
                    fontSize: 8,
                    letterSpacing: .8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your dedicated advisor',
                  style: TextStyle(
                    fontFamily: 'EB Garamond',
                    color: foreground,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Personal assistance for your collection.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: muted,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              shape: const RoundedRectangleBorder(),
            ),
            child: const Text(
              'DIRECT LINE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
