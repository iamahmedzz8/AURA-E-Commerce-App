
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/Gold accent highlight marker.png'),
          Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(text: 'Home', size: 18, weight: FontWeight.w700),
                    Gap(7),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amberAccent,
                      ),
                      margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: CustomText(text: 'Primary', size: 14),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.check, size: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: '12 Tahrir St, Apt 5, Nasr City, Cairo',
                  size: 16,
                  weight: FontWeight.w400,
                  family:''
                ),
                Gap(5),
                Row(
                  children: [
                    Icon(Icons.phone_outlined, color: AppColors.primaryColor),
                    Gap(5),
                    CustomText(text: '+20 100 234 5678',family: '',),
                    
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
