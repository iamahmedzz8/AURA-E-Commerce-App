import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final String? initialCategory;
  const ProductsScreen({super.key, this.initialCategory});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeProductsCubit>(
          create: (_) => sl<HomeProductsCubit>()..fetchProducts(pageSize: 50),
        ),
        BlocProvider<CategoriesCubit>(
          create: (_) => sl<CategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: _ProductsScreenContent(initialCategory: initialCategory),
    );
  }
}

class _ProductsScreenContent extends StatefulWidget {
  final String? initialCategory;
  const _ProductsScreenContent({this.initialCategory});

  @override
  State<_ProductsScreenContent> createState() => _ProductsScreenContentState();
}

class _ProductsScreenContentState extends State<_ProductsScreenContent> {
  static const Color gold = Color(0xFFC5A059);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get background =>
      isDark ? const Color(0xFF080B10) : const Color(0xFFFBF9F5);

  Color get surface => isDark ? const Color(0xFF191C21) : Colors.white;

  Color get foreground => isDark ? Colors.white : const Color(0xFF171717);

  Color get muted =>
      isDark ? const Color(0xFF8A8F98) : const Color(0xFF777777);

  final TextEditingController searchController = TextEditingController();
  late String selectedCategory;
  String? selectedCategoryId;
  final Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? AppStrings.categoryAll;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ProductModel> _filterProducts(List<ProductModel> products) {
    return products.where((product) {
      final matchesCategory = selectedCategory == AppStrings.categoryAll ||
          product.categories.any((c) {
            final cTrimmed = c.trim().toLowerCase();
            final selTrimmed = selectedCategory.trim().toLowerCase();
            return cTrimmed == selTrimmed ||
                cTrimmed.contains(selTrimmed) ||
                (selectedCategoryId != null && c.trim() == selectedCategoryId);
          });

      final query = searchController.text.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          (product.description?.toLowerCase().contains(query) ?? false) ||
          (product.arabicName?.toLowerCase().contains(query) ?? false);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  
void _openProductDetails(ProductModel product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(
            create: (_) => sl<CartCubit>(),
          ),
          BlocProvider<ProductDetailsCubit>(
            create: (_) =>
                ProductDetailsCubit()..getProductsDetails(product.id),
          ),
        ],
        child: ProductDetailsScreen(
          productId: product.id,
          product: {
            'id': product.id,
            'name': product.name,
            'category': product.categories.isNotEmpty
                ? product.categories.first.toUpperCase()
                : 'LUXURY CREATION',
            'price': '${product.price.toInt()} EGP',
            'description': product.description ?? '',
            'rating': product.rating > 0
                ? product.rating.toStringAsFixed(1)
                : '5.0',
            'image': product.coverPictureUrl,
            'tag': product.color.isNotEmpty
                ? product.color.toUpperCase()
                : (product.discountPercentage > 0
                    ? '${product.discountPercentage}% OFF'
                    : 'EXCLUSIVE'),
          },
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: foreground),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.theCollection,
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
                AppStrings.discoverTheCollection,
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
                AppStrings.exceptionalPiecesChosen,
                style: TextStyle(color: muted, fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
              child: TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                style: TextStyle(color: foreground),
                decoration: InputDecoration(
                  hintText: AppStrings.searchTheCollection,
                  hintStyle: TextStyle(color: muted),
                  prefixIcon: const Icon(Icons.search, color: gold),
                  filled: true,
                  fillColor: surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            _buildCategoriesSection(),
            BlocBuilder<HomeProductsCubit, HomeProductsState>(
              builder: (context, state) {
                final allProducts = (state is HomeProductsSuccessState)
                    ? state.products
                    : <ProductModel>[];
                final items = _filterProducts(allProducts);

                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.masterpieces,
                        style: TextStyle(color: foreground, fontSize: 18),
                      ),
                      if (state is HomeProductsSuccessState)
                        Text(
                          '${items.length} pieces',
                          style: TextStyle(color: muted, fontSize: 12),
                        ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  final allProducts = (state is HomeProductsSuccessState)
                      ? state.products
                      : <ProductModel>[];
                  final items = _filterProducts(allProducts);

                  return _buildBody(state, items);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return _buildCategoriesLoading();
        }

        List<CategoryModel> categories = [];
        if (state is CategoriesSuccessState) {
          categories = state.categories;
        }

        return SizedBox(
          height: 42,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = selectedCategory == AppStrings.categoryAll;
                return _buildCategoryChip(
                  label: AppStrings.categoryAll,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedCategory = AppStrings.categoryAll;
                      selectedCategoryId = null;
                    });
                  },
                );
              }

              final category = categories[index - 1];
              final isSelected = selectedCategory == category.name ||
                  (selectedCategoryId != null &&
                      selectedCategoryId == category.id);

              return _buildCategoryChip(
                label: category.name,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedCategory = category.name;
                    selectedCategoryId = category.id;
                  });
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? gold : surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? gold
                : (isDark ? Colors.white12 : Colors.black12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF171717) : foreground,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesLoading() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCategoryChip(
              label: AppStrings.categoryAll,
              isSelected: selectedCategory == AppStrings.categoryAll,
              onTap: () {},
            );
          }
          return Container(
            width: 80,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF191C21) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(HomeProductsState state, List<ProductModel> items) {
    if (state is HomeProductsLoadingState) {
      return _buildLoadingGrid();
    }

    if (state is HomeProductsFailureState) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: gold, size: 48),
              const SizedBox(height: 12),
              Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: foreground, fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: const Color(0xFF171717),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.read<HomeProductsCubit>().fetchProducts(pageSize: 50);
                  context.read<CategoriesCubit>().fetchCategories();
                },
                child: const Text(AppStrings.tryAgain),
              ),
            ],
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return RefreshIndicator(
        color: gold,
        backgroundColor: surface,
        onRefresh: () async {
          await Future.wait([
            context.read<HomeProductsCubit>().fetchProducts(pageSize: 50),
            context.read<CategoriesCubit>().fetchCategories(),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  AppStrings.noPiecesFound,
                  style: TextStyle(color: muted),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: gold,
      backgroundColor: surface,
      onRefresh: () async {
        await Future.wait([
          context.read<HomeProductsCubit>().fetchProducts(pageSize: 50),
          context.read<CategoriesCubit>().fetchCategories(),
        ]);
      },
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 18,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          final product = items[index];
          final isFavorite = favorites.contains(product.id);

          return GestureDetector(
            onTap: () => _openProductDetails(product),
            child: Container(
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
                        if (product.coverPictureUrl.isNotEmpty)
                          Image.network(
                            product.coverPictureUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildFallbackImage(),
                          )
                        else
                          _buildFallbackImage(),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFavorite) {
                                  favorites.remove(product.id);
                                } else {
                                  favorites.add(product.id);
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
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? gold : foreground,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11, 12, 11, 4),
                    child: Text(
                      product.categories.isNotEmpty
                          ? product.categories.first.toUpperCase()
                          : 'EXCLUSIVE',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: gold,
                        fontSize: 9,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: Text(
                      product.name,
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
                    padding: const EdgeInsets.fromLTRB(11, 8, 11, 13),
                    child: Text(
                      '${product.price.toInt()} EGP',
                      style: const TextStyle(
                        color: gold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFallbackImage() {
    return const ColoredBox(
      color: Color(0xFF24272D),
      child: Center(
        child: Icon(
          Icons.watch_outlined,
          color: gold,
          size: 42,
        ),
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
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
                child: Container(
                  color:
                  isDark ? const Color(0xFF24272D) : Colors.grey.shade200,
                  child: const Center(
                    child: Icon(
                      Icons.watch_outlined,
                      color: Colors.white24,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 12, 11, 4),
                child: Container(
                  width: 50,
                  height: 10,
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Container(
                  width: 100,
                  height: 14,
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 8, 11, 13),
                child: Container(
                  width: 70,
                  height: 12,
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
