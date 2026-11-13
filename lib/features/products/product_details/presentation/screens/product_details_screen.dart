import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/theme/theme_cubit.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_state.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/cubit/product_details_state.dart';
import 'package:aura_maison_e_commerce/features/products/products/presentation/screens/products_screen.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/screens/reviews_screen.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/screens/write_review_screen.dart';
import 'package:aura_maison_e_commerce/features/products/reviews/presentation/widgets/reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final String? productId;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static const Color gold = Color(0xFFC5A059);
  static const Color orange = Color(0xFFFF5A1F);
  static const Color darkBackground = Color(0xFF080B10);
  static const Color darkSurface = Color(0xFF191C21);
  static const Color lightBackground = Color(0xFFFBF9F5);
  static const Color lightSurface = Colors.white;

  late final PageController _pageController;

  int _selectedImageIndex = 0;
  int _selectedTab = 0;
  bool _isFavorite = false;
  int _selectedVariant = 0;
  int _quantity = 1;
  bool _addedToBag = false;

  static const List<Map<String, dynamic>> productVariants = [
    {'name': 'Rose Gold', 'color': Color(0xFFC58A70)},
    {'name': 'White Gold', 'color': Color(0xFFD8D8D8)},
    {'name': 'Platinum', 'color': Color(0xFF9DA5AE)},
  ];

  static const List<String> temporaryImages = [
    'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=1000',
    'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=1000',
    'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=1000',
    'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=1000',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=1000',
  ];

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get background => isDark ? darkBackground : lightBackground;

  Color get surface => isDark ? darkSurface : lightSurface;

  Color get foreground => isDark ? Colors.white : const Color(0xFF171717);

  Color get muted => isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  List<String> get productImages {
    final rawImages =
        widget.product['images'] ?? widget.product['productPictures'];

    if (rawImages is String && rawImages.trim().isNotEmpty) {
      final images = rawImages
          .split('|')
          .map((image) => image.trim())
          .where((image) => image.isNotEmpty)
          .toList();
      if (images.isNotEmpty) return images;
    }

    if (rawImages is List) {
      final images = rawImages
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (images.isNotEmpty) return images;
    }

    final mainImage =
        widget.product['image'] ?? widget.product['coverPictureUrl'];
    final imageString = mainImage?.toString() ?? '';

    if (imageString.trim().isNotEmpty) {
      return [
        imageString,
        ...temporaryImages.where((image) => image != imageString),
      ];
    }

    return temporaryImages;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    final productId = (widget.productId ?? widget.product['id'] ?? '')
        .toString();
    if (productId.isNotEmpty) {
      context.read<ProductDetailsCubit>().getProductsDetails(productId);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changeImage(int index) {
    if (index < 0 || index >= productImages.length) return;

    setState(() {
      _selectedImageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void openProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductsScreen()),
    );
  }

  void openAccount() {
    context.read<HomeCubit>().changeTab(4);
    Navigator.pop(context);
  }

  void toggleTheme() {
    context.read<ThemeCubit>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductDetailsCubit>().state;
    final apiProduct = state is ProductDetailsSuccessState
        ? state.productDetailsModel
        : null;
    final productId = (widget.productId ?? widget.product['id'] ?? '')
        .toString();

    final isLoading = state is ProductDetailsLoadingState;
    final productName =
        apiProduct?.name ?? widget.product['name'] ?? 'Royal Tourbillon';
    final productPrice = apiProduct != null
        ? '\$${apiProduct.price.toStringAsFixed(apiProduct.price.truncateToDouble() == apiProduct.price ? 0 : 2)}'
        : (widget.product['price'] ?? '\$124,500').toString();
    final productDescription =
        apiProduct?.description ??
        widget.product['description'] ??
        'Each piece is crafted with premium materials and exceptional attention to detail.';

    final images = apiProduct == null
        ? productImages
        : [
            if (apiProduct.coverImage.trim().isNotEmpty) apiProduct.coverImage,
            ...apiProduct.productImage
                .map((image) => image.toString().trim())
                .where((image) => image.isNotEmpty),
          ].where((image) => image.isNotEmpty).toSet().toList();

    return BlocProvider(
      create: (_) =>
          ReviewsCubit()..getReviews(productId.isEmpty ? '0' : productId),
      child: Builder(
        builder: (context) {
          final reviewsCubit = context.read<ReviewsCubit>();

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: header()),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imageGallery(images, isLoading: isLoading),
                              const SizedBox(height: 20),
                              productHeading(productName),
                              const SizedBox(height: 18),
                              priceCard(productPrice),
                              const SizedBox(height: 16),
                              variantsAndQuantity(),
                              const SizedBox(height: 16),
                              specificationTabs(),
                              const SizedBox(height: 12),
                              specifications(),
                              const SizedBox(height: 18),
                              craftsmanship(productDescription),
                              const SizedBox(height: 18),
                              productReviews(reviewsCubit),
                              const SizedBox(height: 18),
                              curatorCard(),
                              const SizedBox(height: 18),
                              contactSection(),
                              const SizedBox(height: 110),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: bottomActions(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Container(
      color: isDark ? darkBackground : const Color(0xFF101216),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: SizedBox(
        height: 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 36,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  const Text(
                    AppStrings.brandTitleInline,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: gold,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Text(
                AppStrings.productDetailsTitle,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'EB Garamond',
                  color: Colors.white,
                  fontSize: 20,
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
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 36,
                    ),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: openAccount,
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

  Widget imageGallery(List<String>? galleryImages, {bool isLoading = false}) {
    final images = galleryImages ?? productImages;
    return Column(
      children: [
        Container(
          height: 330,
          width: double.infinity,
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: orange,
                    strokeWidth: 2.5,
                  ),
                )
              else if (images.isEmpty)
                Center(
                  child: Icon(Icons.watch_outlined, size: 100, color: muted),
                )
              else
                PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.watch_outlined,
                            size: 100,
                            color: muted,
                          );
                        },
                      ),
                    );
                  },
                ),
              Positioned(
                top: 14,
                left: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageTag(
                      (widget.product['tag'] ?? 'ONE OF A KIND').toString(),
                    ),
                    const SizedBox(height: 5),
                    imageTag('GENEVA SEAL'),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? orange : foreground,
                  ),
                ),
              ),
              if (!isLoading && images.isNotEmpty)
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_selectedImageIndex + 1} / ${images.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (isLoading)
          SizedBox(
            height: 76,
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isDark ? darkSurface : const Color(0xFFEDEAE4),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: orange,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        else if (images.isNotEmpty)
          SizedBox(
            height: 76,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final selected = index == _selectedImageIndex;

                return GestureDetector(
                  onTap: () => changeImage(index),
                  child: Container(
                    width: 76,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: selected ? orange : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.watch_outlined, color: muted);
                      },
                    ),
                  ),
                );
              },
            ),
          )
        else
          const SizedBox(height: 76),
      ],
    );
  }

  Widget imageTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EEE8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF66543B),
          fontSize: 9,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget productHeading(String productName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              AppStrings.inHouseCalibre8801,
              style: TextStyle(
                color: orange,
                fontSize: 10,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(Icons.circle, color: Colors.green.shade400, size: 7),
            const SizedBox(width: 5),
            Text(
              AppStrings.availableNow,
              style: TextStyle(color: muted, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          productName,
          style: TextStyle(
            color: foreground,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'REF. TS-880-OR • 18K Rose Gold • 41mm • Unique Edition',
          style: TextStyle(color: muted, fontSize: 11),
        ),
      ],
    );
  }

  Widget priceCard(String productPrice) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productPrice,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.vatIncludedCertified,
                  style: TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const Icon(Icons.local_shipping_outlined, color: orange, size: 22),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'COMPLIMENTARY\nARMORED TRANSPORT',
              style: TextStyle(
                color: orange,
                fontSize: 9,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget variantsAndQuantity() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.chooseYourFinish,
                  style: TextStyle(
                    color: muted,
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                productVariants[_selectedVariant]['name'] as String,
                style: TextStyle(
                  color: foreground,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(productVariants.length, (index) {
              final selected = _selectedVariant == index;
              final variantColor = productVariants[index]['color'] as Color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedVariant = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? orange : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: variantColor,
                      border: Border.all(
                        color: isDark ? Colors.white24 : Colors.black12,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          Divider(height: 1, color: isDark ? Colors.white12 : Colors.black12),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.quantity,
                      style: TextStyle(
                        color: muted,
                        fontSize: 10,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.selectNumberOfPieces,
                      style: TextStyle(color: muted, fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? Colors.white24 : Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _quantity > 1
                          ? () {
                              setState(() {
                                _quantity--;
                              });
                            }
                          : null,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.remove, size: 16),
                      color: foreground,
                      disabledColor: muted.withValues(alpha: 0.4),
                    ),
                    SizedBox(
                      width: 24,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: foreground,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add, size: 16),
                      color: foreground,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget specificationTabs() {
    const tabs = [
      'CALIBRE & MOVEMENT',
      'CASE & MATERIALS',
      'PROVENANCE & VAULT',
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final selected = _selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                  color: selected ? gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? Colors.black : foreground,
                    fontSize: 8,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget specifications() {
    final specs = _selectedTab == 0
        ? const [
            ['Signature Calibre', 'AURA Cal. 8801 In-House'],
            ['High Complication', 'Flying Tourbillon & Hand Skeletonization'],
            ['Oscillation Frequency', '21,600 vph (3 Hz)'],
            ['Power Reserve', '72 Hours (Twin Barrel)'],
            ['Hand Finishing', 'Mirror-Polished Beveling'],
          ]
        : _selectedTab == 1
        ? const [
            ['Case Material', '18K Rose Gold'],
            ['Case Diameter', '41.0 mm'],
            ['Crystal', 'Sapphire Crystal'],
            ['Water Resistance', '5 ATM (50 Meters)'],
            ['Strap', 'Hand-Stitched Alligator'],
          ]
        : const [
            ['Edition', 'One of a Kind'],
            ['Certificate', 'Geneva Seal'],
            ['Origin', 'Geneva, Switzerland'],
            ['Authentication', 'Certified Timepiece'],
            ['Delivery', 'Armored Transport'],
          ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: specs.map((spec) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    spec[0],
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    spec[1],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: foreground,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget craftsmanship(String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: orange, size: 18),
              const SizedBox(width: 8),
              Text(
                AppStrings.theArtOfOpenworking,
                style: TextStyle(
                  color: foreground,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: muted, fontSize: 12, height: 1.6),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: craftsmanshipInfo(
                  'HAND ENGRAVING',
                  '180 Hours',
                  'Individual Craftsmanship',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: craftsmanshipInfo(
                  'BEVELED PERIMETER',
                  '42 Corners',
                  'Internal & Sharp',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget craftsmanshipInfo(String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF22252B) : const Color(0xFFF7F4EF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: orange,
              fontSize: 9,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: foreground,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: muted, fontSize: 9)),
        ],
      ),
    );
  }

  Widget productReviews(ReviewsCubit reviewsCubit) {
    final state = context.watch<ProductDetailsCubit>().state;
    final apiProduct = state is ProductDetailsSuccessState
        ? state.productDetailsModel
        : null;
    final productId = (widget.productId ?? widget.product['id'] ?? '')
        .toString();
    final productName = widget.product['name'] ?? 'Royal Tourbillon';
    final productImage = apiProduct != null
        ? (apiProduct.coverImage.trim().isNotEmpty
              ? apiProduct.coverImage
              : (apiProduct.productImage.isNotEmpty
                    ? apiProduct.productImage.first.toString()
                    : ''))
        : ((widget.product['image'] ?? widget.product['coverPictureUrl'] ?? '')
                  .toString()
                  .trim()
                  .isNotEmpty
              ? (widget.product['image'] ?? widget.product['coverPictureUrl'])
                    .toString()
              : (widget.product['images'] is List &&
                        (widget.product['images'] as List).isNotEmpty
                    ? (widget.product['images'] as List).first.toString()
                    : ''));

    return ReviewsSummaryCard(
      productId: productId,
      productName: productName,
      onViewAll: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReviewsScreen(
              productId: productId,
              productName: productName,
              productImage: productImage,
            ),
          ),
        );
      },
      onWriteReview: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: reviewsCubit,
              child: WriteReviewScreen(
                productName: productName,
                productId: productId,
                productImage: productImage,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget curatorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, color: gold, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.dedicatedPrivateCurator,
                  style: TextStyle(
                    color: orange,
                    fontSize: 9,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Antoine de Valois',
                  style: TextStyle(
                    color: foreground,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  AppStrings.vendomeSalonClientRelations,
                  style: TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          Icon(Icons.circle, color: Colors.green.shade400, size: 9),
        ],
      ),
    );
  }

  Widget contactSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.availableViaEncryptedCall,
                style: TextStyle(color: foreground, fontSize: 11),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.call, size: 15, color: orange),
              label: const Text(
                AppStrings.secureLine,
                style: TextStyle(color: orange, fontSize: 10),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: orange.withValues(alpha: 0.3)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user_outlined, color: gold, size: 14),
            const SizedBox(width: 6),
            Text(
              AppStrings.personalHandoverEscort,
              style: TextStyle(color: muted, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
      decoration: BoxDecoration(
        color: background,
        border: Border(
          top: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_outlined, size: 15),
              label: const Text(
                AppStrings.inquireAdvisor,
                style: TextStyle(fontSize: 10),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: foreground,
                side: BorderSide(
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                final String? productId = widget.product['id'];

                if (productId == null || productId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product ID is missing')),
                  );
                  return;
                }

                await context.read<CartCubit>().addToCart(
                  productId: productId,
                  quantity: _quantity,
                );

                if (!mounted) return;

                final state = context.read<CartCubit>().state;

                if (state is CartSuccess) {
                  setState(() {
                    _addedToBag = true;
                  });

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added to bag • Quantity: $_quantity • ${productVariants[_selectedVariant]['name']}',
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: gold,
                      ),
                    );
                } else if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              icon: Icon(
                _addedToBag ? Icons.check_rounded : Icons.shopping_bag_outlined,
                size: 15,
              ),
              label: Text(
                _addedToBag ? 'ADDED TO BAG' : 'ADD TO BAG',
                style: const TextStyle(fontSize: 10),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
