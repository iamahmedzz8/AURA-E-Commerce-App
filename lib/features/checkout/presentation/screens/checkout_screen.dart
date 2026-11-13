import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_state.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_summary.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/address_container.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/button_and_privacy_section.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/check_privacy.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/delivery_address.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/payment_method.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/payment_section.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/promo_code_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:aura_maison_e_commerce/core/services/selected_address_service.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/entities/address_entity.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/screens/add_address_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AddressEntity? selectedAddress;

  @override
  void initState() {
    super.initState();
    _loadSelectedAddress();
  }

  Future<void> _loadSelectedAddress() async {
    final selectedAddressService = sl<SelectedAddressService>();
    final savedAddressId = selectedAddressService.getAddressId();

    if (savedAddressId != null && savedAddressId.isNotEmpty) {
      context.read<AddressesCubit>().getAddressById(savedAddressId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 40,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.checkout,
          size: 25,
          weight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckPrivacy(),
              Gap(10),
              DeliveryAddress(
                onChange: () async {
                  final AddressEntity? newAddress =
                      await Navigator.push<AddressEntity>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => sl<AddressesCubit>(),
                            child: const AddAddressScreen(),
                          ),
                        ),
                      );

                  if (newAddress != null && mounted) {
                    setState(() {
                      selectedAddress = newAddress;
                    });
                  }
                },
              ),
              Gap(10),
              BlocBuilder<AddressesCubit, AddressesState>(
                builder: (context, state) {
                  if (selectedAddress != null) {
                    return AddressContainer(
                      address: selectedAddress!,
                      onEdit: () async {
                        final AddressEntity? updatedAddress =
                            await Navigator.push<AddressEntity>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => sl<AddressesCubit>(),
                                  child: AddAddressScreen(
                                    address: selectedAddress!,
                                  ),
                                ),
                              ),
                            );

                        if (updatedAddress != null && mounted) {
                          setState(() {
                            selectedAddress = updatedAddress;
                          });
                        }
                      },
                    );
                  }

                  if (state is AddressesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is AddressLoaded) {
                    return AddressContainer(
                      address: state.address,
                      onEdit: () async {
                        final AddressEntity? updatedAddress =
                            await Navigator.push<AddressEntity>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => sl<AddressesCubit>(),
                                  child: AddAddressScreen(
                                    address: state.address,
                                  ),
                                ),
                              ),
                            );

                        if (updatedAddress != null && mounted) {
                          setState(() {
                            selectedAddress = updatedAddress;
                          });
                        }
                      },
                    );
                  }

                  if (state is AddressesError) {
                    return Text(state.message);
                  }

                  return const SizedBox.shrink();
                },
              ),
              Gap(20),
              PaymentMethod(),
              Gap(10),
              PaymentSection(),
              Gap(20),
              PromoCodeSection(),
              Gap(20),
              BlocProvider(
                create: (_) => sl<CartCubit>()..getCart(),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading || state is CartInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CartSuccess) {
                      return CartSummary(cart: state.cart);
                    }

                    if (state is CartError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              Gap(20),
              ButtonAndPrivacySection(),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
