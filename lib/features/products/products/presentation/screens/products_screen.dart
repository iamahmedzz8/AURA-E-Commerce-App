import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const Color gold = Color(0xFFC5A059);

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get background =>
      isDark ? const Color(0xFF080B10) : const Color(0xFFFBF9F5);

  Color get surface =>
      isDark ? const Color(0xFF191C21) : Colors.white;

  Color get foreground =>
      isDark ? Colors.white : const Color(0xFF171717);

  Color get muted =>
      isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';
  final Set<int> favorites = {};

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Imperial Chronograph',
      'category': 'Watches',
      'price': 210000,
      'image':
      'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=700',
    },
    {
      'name': 'Celeste Perpetual',
      'category': 'Watches',
      'price': 185000,
      'image':
      'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=700',
    },
    {
      'name': 'Royal Gold Bracelet',
      'category': 'Jewelry',
      'price': 42000,
      'image':
      'https://images.unsplash.com/photo-1611652022419-a9419f355e2b?w=700',
    },
    {
      'name': 'Maison Leather',
      'category': 'Leather',
      'price': 28000,
      'image':
      'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=700',
    },
    {
      'name': 'Classic Heritage',
      'category': 'Watches',
      'price': 96000,
      'image':
      'https://images.unsplash.com/photo-1533139502658-0198f920d8e8?w=700',
    },
    {
      'name': 'Golden Minimal',
      'category': 'Jewelry',
      'price': 35000,
      'image':
      'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=700',
    },
  ];

  final List<String> categories = [
    'All',
    'Watches',
    'Jewelry',
    'Leather',
    'Eyewear',
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredProducts;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: foreground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'THE COLLECTION',
          style: TextStyle(
            color: gold,
            fontSize: 14,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Text(
                'Discover the Collection',
                style: TextStyle(
                  color: foreground,
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Exceptional pieces, chosen for you.',
                style: TextStyle(
                  color: muted,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                style: TextStyle(color: foreground),
                decoration: InputDecoration(
                  hintText: 'Search the collection',
                  hintStyle: TextStyle(color: muted),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: gold,
                  ),
                  filled: true,
                  fillColor: surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? gold : surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: selected
                              ? gold
                              : (isDark
                              ? Colors.white12
                              : Colors.black12),
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFF171717)
                              : foreground,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Masterpieces',
                    style: TextStyle(
                      color: foreground,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${items.length} pieces',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? Center(
                child: Text(
                  'No pieces found',
                  style: TextStyle(color: muted),
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  24,
                ),
                itemCount: items.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = items[index];
                  final favorite = favorites.contains(index);

                  return Container(
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                product['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                const ColoredBox(
                                  color: Color(0xFF24272D),
                                  child: Icon(
                                    Icons.watch,
                                    color: gold,
                                    size: 42,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (favorite) {
                                        favorites.remove(index);
                                      } else {
                                        favorites.add(index);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: background,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favorite
                                          ? gold
                                          : foreground,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            11,
                            12,
                            11,
                            4,
                          ),
                          child: Text(
                            product['category']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              color: gold,
                              fontSize: 9,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                          ),
                          child: Text(
                            product['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: foreground,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            11,
                            8,
                            11,
                            13,
                          ),
                          child: Text(
                            '${product['price']} EGP',
                            style: const TextStyle(
                              color: gold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}