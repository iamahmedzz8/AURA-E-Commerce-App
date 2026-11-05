import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddressContainer extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onEdit;

  const AddressContainer({
    super.key,
    required this.address,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final addressDetails =
        '${address.street}, Apt ${address.apartment}, '
        '${address.city}, ${address.state}';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/Gold accent highlight marker.png',
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: 'Home',
                      size: 18,
                      weight: FontWeight.w700,
                    ),
                    const Gap(7),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amberAccent,
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: const CustomText(
                        text: 'Primary',
                        size: 14,
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: addressDetails,
                  size: 16,
                  weight: FontWeight.w400,
                  family: '',
                ),
                const Gap(5),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      color: AppColors.primaryColor,
                    ),
                    const Gap(5),
                    CustomText(
                      text: address.phoneNumber,
                      family: '',
                    ),
                  ],
                ),

                const Gap(8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                    label: const CustomText(
                      text: 'Edit',
                      size: 14,
                      color: AppColors.primaryColor,
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
}