import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/entities/address_entity.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_state.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/screens/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UserAddressesScreen extends StatefulWidget {
  const UserAddressesScreen({super.key});

  @override
  State<UserAddressesScreen> createState() => _UserAddressesScreenState();
}

class _UserAddressesScreenState extends State<UserAddressesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressesCubit>().getUserAddresses();
  }

  Future<void> _openAddAddress() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddAddressScreen(),
      ),
    );

    if (!mounted) return;
    context.read<AddressesCubit>().getUserAddresses();
  }

  Future<void> _openEditAddress(AddressEntity address) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddAddressScreen(address: address),
      ),
    );

    if (!mounted) return;
    context.read<AddressesCubit>().getUserAddresses();
  }



  Future<void> _confirmDeleteAddress(AddressEntity address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text(
            'Are you sure you want to delete this address?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    await context.read<AddressesCubit>().deleteAddress(address.id);
  }

  Widget _buildAddressCard(AddressEntity address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const Gap(8),
              Expanded(
                child: CustomText(
                  text: '${address.city}, ${address.state}',
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => _openEditAddress(address),
                icon: const Icon(Icons.edit_outlined),
                color: AppColors.primaryColor,
                tooltip: 'Edit address',
              ),

              IconButton(
                onPressed: () => _confirmDeleteAddress(address),
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
                tooltip: 'Delete address',
              ),
            ],
          ),
          const Gap(8),
          Text(
            '${address.street}, ${address.apartment}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(6),
          Text(
            address.phoneNumber,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (address.notes.trim().isNotEmpty) ...[
            const Gap(6),
            Text(
              address.notes,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AddressesCubit, AddressesState>(
      builder: (context, state) {
        if (state is AddressesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is AddressesError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const Gap(12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AddressesCubit>().getUserAddresses();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is UserAddressesLoaded) {
          if (state.addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_off_outlined,
                    size: 56,
                  ),
                  const Gap(12),
                  const Text(
                    'You haven’t added any addresses yet',
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: _openAddAddress,
                    child: const Text('Add Address'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<AddressesCubit>().getUserAddresses();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(state.addresses[index]);
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'My Addresses',
          size: 22,
          weight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: _openAddAddress,
            icon: const Icon(Icons.add),
            tooltip: 'Add address',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}