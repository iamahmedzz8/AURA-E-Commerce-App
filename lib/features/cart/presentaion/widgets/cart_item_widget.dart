import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/data/models/cart_item_model.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final bool isUpdating;

  const CartItemWidget({
    super.key,
    required this.item,
    this.isUpdating = false,
  });

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Remove from cart'),
        content: Text(
          'Are you sure you want to remove "${item.productName}" from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text(
              'Remove',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _onIncrement(BuildContext context) {
    if (isUpdating) return;

    if (item.productStock > 0 && item.quantity >= item.productStock) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Cannot add more. Max available stock is ${item.productStock}.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    context.read<CartCubit>().addToCart(
          productId: item.productId,
          quantity: 1,
          itemId: item.itemId,
        );
  }

  Future<void> _onDecrement(BuildContext context) async {
    if (isUpdating) return;

    if (item.quantity > 1) {
      context.read<CartCubit>().decrementCartItem(
            itemId: item.itemId,
            quantity: 1,
          );
    } else {
      final confirmed = await _confirmDelete(context);
      if (confirmed && context.mounted) {
        context.read<CartCubit>().deleteCartItem(
              itemId: item.itemId,
            );
      }
    }
  }

  Future<void> _onDelete(BuildContext context) async {
    if (isUpdating) return;

    final confirmed = await _confirmDelete(context);
    if (confirmed && context.mounted) {
      context.read<CartCubit>().deleteCartItem(
            itemId: item.itemId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.productCoverUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/watch.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: item.productName,
                  size: 16,
                  weight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  maxLines: 1,
                ),
                const Gap(4),
                CustomText(
                  text: '${item.finalPricePerUnit.toStringAsFixed(2)} EGP',
                  weight: FontWeight.w500,
                  size: 14,
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffECE6DA),
                      ),
                      child: isUpdating
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 30,
                                    minHeight: 30,
                                  ),
                                  onPressed: isUpdating
                                      ? null
                                      : () => _onDecrement(context),
                                  icon: const Icon(Icons.remove, size: 16),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: CustomText(
                                    text: item.quantity.toString(),
                                    size: 15,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 30,
                                    minHeight: 30,
                                  ),
                                  onPressed: isUpdating
                                      ? null
                                      : () => _onIncrement(context),
                                  icon: const Icon(Icons.add, size: 16),
                                ),
                              ],
                            ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: isUpdating ? null : () => _onDelete(context),
                      icon: isUpdating
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            )
                          : const Icon(
                              Icons.delete_outlined,
                              color: Colors.red,
                              size: 22,
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
}
