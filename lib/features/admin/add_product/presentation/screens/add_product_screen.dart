import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../features/products/products/presentation/cubit/products_cubit.dart';
import '../../../../products/products/domain/entities/products_entity.dart';
import '../widgets/add_product_app_bar.dart';
import '../widgets/add_product_title_section.dart';
import '../widgets/identity_section.dart';
import '../widgets/imagery_section.dart';
import '../widgets/notes_section.dart';
import '../widgets/specifications_section.dart';
import '../widgets/valuation_section.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameArabicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nameArabicController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: DarkTheme.background,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 85,
              title: const AddProductAppBar(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const AddProductTitleSection(),
                  const SizedBox(height: 24),
                  const ImagerySection(),
                  const SizedBox(height: 16),
                  IdentitySection(
                    nameController: nameController,
                    nameArabicController: nameArabicController,
                    descriptionController: descriptionController,
                  ),
                  const SizedBox(height: 16),
                  ValuationSection(
                    priceController: priceController,
                    stockController: stockController,
                  ),
                  const SizedBox(height: 16),
                  const SpecificationsSection(),
                  const SizedBox(height: 16),
                  NotesSection(),
                  const SizedBox(height: 24),
                  BlocConsumer<ProductsCubit, ProductsState>(
                    listener: (context, state) {
                      if (state is AddProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product Added Successfully!'), backgroundColor: Colors.green),
                        );
                      } else if (state is AddProductFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DarkTheme.gold,
                            foregroundColor: DarkTheme.background,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: state is AddProductLoading ? null : () {
                            final newProduct = ProductEntity(
                              id: "",
                              name: nameController.text.isNotEmpty ? nameController.text : "Test Watch",
                              nameArabic: nameArabicController.text.isNotEmpty ? nameArabicController.text : "ساعة تجريبية",
                              description: descriptionController.text.isNotEmpty ? descriptionController.text : "Test Description",
                              descriptionArabic: "وصف تجريبي",
                              coverPictureUrl: imageUrlController.text.isNotEmpty ? imageUrlController.text : "https://picsum.photos/200",
                              price: double.tryParse(priceController.text) ?? 10.0,
                              stock: int.tryParse(stockController.text) ?? 1,
                              weight: 0.0,
                              color: "Silver",
                              discountPercentage: 0.0,
                              categoryIds: [],
                              productPictureUrls: [],
                            );

                            context.read<ProductsCubit>().addProduct(newProduct);
                          },
                          icon: state is AddProductLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Icon(Icons.save_outlined, size: 18),
                          label: Text(
                            state is AddProductLoading ? 'SAVING...' : 'SAVE TO SOVEREIGN REGISTER',
                            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'Inter'),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel and return to inventory', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 12, fontFamily: 'Inter')),
                    ),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}