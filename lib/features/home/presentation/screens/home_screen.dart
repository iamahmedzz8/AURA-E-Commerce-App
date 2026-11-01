import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = true;
  int selectedTab = 0;
  final Set<int> favorites = {};

  static const gold = Color(0xFFC5A059);
  static const products = [
    {
      'name': 'Royal Tourbillon',
      'category': 'FINE WATCHMAKING',
      'price': '\$124,500',
      'image':
      'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=700',
    },
    {
      'name': 'Étoile Solitaire',
      'category': 'HIGH JEWELRY',
      'price': '\$88,000',
      'image':
      'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=700',
    },
    {
      'name': 'Vendôme Matte Black',
      'category': 'LEATHER GOODS',
      'price': '\$16,800',
      'image':
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=700',
    },
    {
      'name': 'Éclipse Aviator',
      'category': 'EYEWEAR',
      'price': '\$3,400',
      'image':
      'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=700',
    },
  ];

  Color get background =>
      isDark ? const Color(0xFF080B10) : const Color(0xFFFBF9F5);

  Color get surface =>
      isDark ? const Color(0xFF191C21) : Colors.white;

  Color get foreground =>
      isDark ? Colors.white : const Color(0xFF171717);

  Color get muted =>
      isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: header()),
            SliverToBoxAdapter(child: hero()),
            SliverToBoxAdapter(child: collection()),
            SliverToBoxAdapter(child: disciplines()),
            SliverToBoxAdapter(child: section('Featured Masterpieces', 'VIEW ALL')),
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
                  childAspectRatio: .67,
                ),
              ),
            ),
            SliverToBoxAdapter(child: section('Discover the House', 'EXPLORE')),
            SliverToBoxAdapter(child: editorial()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: navigation(),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            'AURA MAISON',
            style: TextStyle(
              color: gold,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Icon(Icons.search, color: foreground),
          const SizedBox(width: 18),
          Icon(Icons.notifications_none, color: foreground),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () => setState(() => isDark = !isDark),
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget hero() {
    return Container(
      height: 390,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=1200',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: .9),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LIMITED EDITION • 25 PIECES',
              style: TextStyle(color: gold, fontSize: 9, letterSpacing: 1.5),
            ),
            const Spacer(),
            const Text(
              'FINE WATCHMAKING',
              style: TextStyle(color: gold, fontSize: 10, letterSpacing: 1.5),
            ),
            const SizedBox(height: 8),
            const Text(
              'Imperial Chronograph',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'EB Garamond',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Swiss precision, composed in-house.',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Text(
                  '\$210,000',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text(
                    'ACQUIRE ALLOCATION',
                    style: TextStyle(fontSize: 9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget collection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      padding: const EdgeInsets.all(14),
      color: surface,
      child: Row(
        children: [
          const Icon(Icons.diamond_outlined, color: gold, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRIVATE INVITATION',
                  style: TextStyle(color: gold, fontSize: 9),
                ),
                const SizedBox(height: 5),
                Text(
                  'Genève Watches & Wonders Preview',
                  style: TextStyle(color: foreground, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'Private access before public opening.',
                  style: TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: gold, size: 14),
        ],
      ),
    );
  }

  Widget disciplines() {
    final items = [
      (Icons.watch_outlined, 'WATCHES'),
      (Icons.diamond_outlined, 'JEWELRY'),
      (Icons.shopping_bag_outlined, 'LEATHER'),
      (Icons.visibility_outlined, 'EYEWEAR'),
    ];

    return Column(
      children: [
        section('Curated Disciplines', 'ARCHIVES'),
        SizedBox(
          height: 85,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) => Container(
              width: 80,
              color: surface,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[index].$1, color: gold, size: 25),
                  const SizedBox(height: 8),
                  Text(
                    items[index].$2,
                    style: TextStyle(color: foreground, fontSize: 9),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget section(String title, String action) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: foreground,
                fontSize: 21,
                fontFamily: 'EB Garamond',
              ),
            ),
          ),
          Text(
            action,
            style: const TextStyle(
              color: gold,
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios, color: gold, size: 10),
        ],
      ),
    );
  }

  Widget productCard(int index) {
    final item = products[index];
    final favorite = favorites.contains(index);

    return Container(
      color: surface,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.watch,
                    color: gold,
                    size: 45,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        favorite
                            ? favorites.remove(index)
                            : favorites.add(index);
                      });
                    },
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: gold,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['category']!,
                  style: const TextStyle(color: gold, fontSize: 8),
                ),
                const SizedBox(height: 5),
                Text(
                  item['name']!,
                  maxLines: 2,
                  style: TextStyle(color: foreground, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  item['price']!,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: foreground,
                      side: const BorderSide(color: gold),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'RESERVE',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editorial() {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=1200',
          ),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(18),
      child: const Text(
        'Céleste Orrery\nPerpetual Motion',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'EB Garamond',
        ),
      ),
    );
  }

  Widget navigation() {
    final items = [
      (Icons.home_outlined, 'HOME'),
      (Icons.diamond_outlined, 'COLLECTIONS'),
      (Icons.shopping_bag_outlined, 'BAG'),
      (Icons.favorite_border, 'FAVORITES'),
      (Icons.person_outline, 'PROFILE'),
    ];

    return Container(
      color: surface,
      child: SafeArea(
        child: Row(
          children: List.generate(
            items.length,
                (index) => Expanded(
              child: InkWell(
                onTap: () => setState(() => selectedTab = index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index].$1,
                        color: selectedTab == index ? gold : muted,
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].$2,
                        style: TextStyle(
                          color: selectedTab == index ? gold : muted,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
