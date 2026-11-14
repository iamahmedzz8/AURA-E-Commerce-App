import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:aura_maison_e_commerce/features/addresses/presentation/cubit/addresses_state.dart';
import 'package:aura_maison_e_commerce/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressEntity? address;

  const AddAddressScreen({super.key, this.address});

  bool get isEditMode => address != null;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  @override
  void initState() {
    super.initState();

    final address = widget.address;

    if (address != null) {
      _stateController.text = address.state;
      _cityController.text = address.city;
      _streetController.text = address.street;
      _apartmentController.text = address.apartment;
      _phoneController.text = address.phoneNumber;
      _notesController.text = address.notes;
    }
  }

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _apartmentController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool requiredField = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label, size: 15, weight: FontWeight.w600),
        const Gap(8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (value) {
            if (requiredField && (value == null || value.trim().isEmpty)) {
              return '$label is required';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
            ),
          ),
        ),
      ],
    );
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    final address = widget.address;

    if (widget.isEditMode && address != null) {
      context.read<AddressesCubit>().updateAddress(
        id: address.id,
        state: _stateController.text.trim(),
        city: _cityController.text.trim(),
        street: _streetController.text.trim(),
        apartment: _apartmentController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        notes: _notesController.text.trim(),
      );
    } else {
      context.read<AddressesCubit>().createAddress(
        state: _stateController.text.trim(),
        city: _cityController.text.trim(),
        street: _streetController.text.trim(),
        apartment: _apartmentController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        notes: _notesController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEditMode
              ? AppStrings.editAddress
              : AppStrings.addNewAddress,
          size: 22,
          weight: FontWeight.bold,
        ),
      ),
      body: BlocListener<AddressesCubit, AddressesState>(
        listener: (context, state) {
          if (state is AddressCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.addressSavedSuccessfully),
              ),
            );

            Navigator.pop(context, state.address);
          }

          if (state is AddressLoaded && widget.isEditMode) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.addressUpdatedSuccessfully),
              ),
            );

            Navigator.pop(context, state.address);
          }

          if (state is AddressesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildField(
                  label: AppStrings.stateLabel,
                  controller: _stateController,
                ),
                const Gap(16),
                _buildField(
                  label: AppStrings.cityLabel,
                  controller: _cityController,
                ),
                const Gap(16),
                _buildField(
                  label: AppStrings.streetLabel,
                  controller: _streetController,
                ),
                const Gap(16),
                _buildField(
                  label: AppStrings.apartmentLabel,
                  controller: _apartmentController,
                ),
                const Gap(16),
                _buildField(
                  label: AppStrings.phoneLabel,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const Gap(16),
                _buildField(
                  label: AppStrings.notesLabel,
                  controller: _notesController,
                  maxLines: 3,
                  requiredField: false,
                ),
                const Gap(24),
                BlocBuilder<AddressesCubit, AddressesState>(
                  builder: (context, state) {
                    final isLoading = state is AddressesLoading;

                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                widget.isEditMode
                                    ? AppStrings.updateAddress
                                    : AppStrings.saveAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
