
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: BlocBuilder<CartCubit, CartState>(
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
                  return const Center(
                    child: Text('Your shopping bag is empty'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.shoppingBag,
                          size: 22,
                          weight: FontWeight.w600,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffF3E8CC),
                          ),
                          child: Center(
                            child: CustomText(
                              text: itemsCount.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) =>
                            const Gap(12),
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            item: cartItems[index],
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    CartCuponWidget(),
                    const Gap(10),
                    CartSummary(cart: state.cart),
                    CheckoutButton(),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
