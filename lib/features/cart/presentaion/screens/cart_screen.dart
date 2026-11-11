import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_state.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_cupon_widget.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_item_widget.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_summary.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/checkout_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartCubit>()..getCart(),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartActionError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent,
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is CartLoading || state is CartInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const Gap(12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().getCart();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is CartSuccess) {
              final cartItems = state.cart.cartItems;

              final itemsCount = cartItems.fold<int>(
                0,
                (sum, item) => sum + item.quantity,
              );

              if (cartItems.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => context.read<CartCubit>().getCart(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const Gap(16),
                            const CustomText(
                              text: 'Your shopping bag is empty',
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<CartCubit>().getCart(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.shoppingBag,
                            size: 22,
                            weight: FontWeight.w600,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xffF3E8CC),
                            ),
                            child: Center(
                              child: CustomText(
                                text: itemsCount.toString(),
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),

                      // Cart Items List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) =>
                            const Gap(12),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemWidget(
                            item: item,
                            isUpdating: state.updatingItemId == item.itemId,
                          );
                        },
                      ),
                      const Gap(16),

                      // Coupon Section
                      const CartCuponWidget(),
                      const Gap(16),

                      // Price Summary
                      CartSummary(cart: state.cart),
                      const Gap(16),

                      // Checkout Button
                      const CheckoutButton(),

                      // Safe margin for the floating bottom navigation bar
                      const Gap(100),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
