import 'package:aura_maison_e_commerce/features/support/contact/presentation/widgets/contact_common_widgets.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/widgets/contact_selection_widgets.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/widgets/curator_widgets.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/cubit/support_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _referenceController = TextEditingController();

  final TextEditingController _instructionsController = TextEditingController();

  String selectedCategory = 'Rare Complication Acquisition';

  int selectedPriority = 0;
  int selectedResponseMethod = 0;

  SupportRequestStatus? requestStatus;

  static const int maxInstructionsLength = 1000;

  static const List<String> categories = [
    'Rare Complication Acquisition',
    'Private Viewing Appointment',
    'Authenticity & Documentation',
    'Delivery & Collection',
    'After-Sales Service',
    'Other Private Request',
  ];

  @override
  void dispose() {
    _referenceController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration({
    required String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF858991), fontSize: 13),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF1B1E23),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: AppColors.goldAccent.withOpacity(0.7),
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }

  void _sendRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    // UI testing only: no API request is sent yet.
    setState(() {
      requestStatus = SupportRequestStatus.success;
    });
  }

  void _resetRequestForm() {
    setState(() {
      requestStatus = null;
    });
  }

  Widget _buildSectionSpacing([double height = 20]) {
    return SizedBox(height: height);
  }

  Widget _buildInstructionsCounter() {
    return ContactSectionLabel(
      title: 'Specific Instructions',
      trailing:
          '${_instructionsController.text.length} / $maxInstructionsLength',
    );
  }

  Widget _buildInstructionsField() {
    return TextFormField(
      controller: _instructionsController,
      maxLines: 5,
      minLines: 5,
      maxLength: maxInstructionsLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (_) => setState(() {}),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your instructions.';
        }

        return null;
      },
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 13,
        height: 1.6,
      ),
      decoration: _fieldDecoration(
        hint: 'Please share your confidential instructions...',
      ).copyWith(counterText: '', alignLabelWithHint: true),
    );
  }

  Widget _buildInstructionsActions() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, color: AppColors.goldAccent, size: 13),
            SizedBox(width: 5),
            Text(
              'End-to-end encryption',
              style: TextStyle(
                color: AppColors.goldAccent,
                fontSize: 10,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            _instructionsController.clear();
            setState(() {});
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'Clear',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      isExpanded: true,
      dropdownColor: const Color(0xFF25282D),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.goldAccent),
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
      decoration: _fieldDecoration(hint: 'Select request category'),
      items: categories.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category, maxLines: 1, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
        }
      },
    );
  }

  Widget _buildReferenceField() {
    return TextFormField(
      controller: _referenceController,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
      decoration: _fieldDecoration(
        hint: '#AM-2025-8849-VDM',
        prefixIcon: const Icon(
          Icons.tag,
          color: AppColors.textSecondary,
          size: 19,
        ),
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return ContactPrioritySelector(
      selectedIndex: selectedPriority,
      onChanged: (index) {
        setState(() {
          selectedPriority = index;
        });
      },
    );
  }

  Widget _buildResponseMethods() {
    return Column(
      children: [
        ContactResponseTile(
          icon: Icons.call_outlined,
          title: 'Encrypted phone call',
          subtitle: 'Encrypted line certified by our operator',
          selected: selectedResponseMethod == 0,
          onTap: () {
            setState(() {
              selectedResponseMethod = 0;
            });
          },
        ),
        ContactResponseTile(
          icon: Icons.chat_bubble_outline,
          title: 'Secure in-app messaging',
          subtitle: 'Direct transmission via your private salon',
          selected: selectedResponseMethod == 1,
          onTap: () {
            setState(() {
              selectedResponseMethod = 1;
            });
          },
        ),
        ContactResponseTile(
          icon: Icons.apartment_outlined,
          title: 'In-person salon appointment',
          subtitle: 'Place Vendôme, Salon Gabriel (Private Booking)',
          selected: selectedResponseMethod == 2,
          onTap: () {
            setState(() {
              selectedResponseMethod = 2;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton.icon(
        onPressed: _sendRequest,
        icon: const Icon(Icons.send_outlined, color: Colors.black, size: 17),
        label: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'SEND REQUEST TO THE CURATOR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldAccent,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFF202329),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.goldAccent,
              size: 13,
            ),
          ),
        ),
        SizedBox(height: 9),
        Text(
          'AURA MAISON • FINE WATCHMAKING & HERITAGE\n'
          'CURATION',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 9,
            letterSpacing: 0.8,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent(double availableWidth) {
    return Form(
      key: _formKey,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          availableWidth < 360 ? 14 : 20,
          14,
          availableWidth < 360 ? 14 : 20,
          28,
        ),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: ContactMandateBadge(),
          ),

          _buildSectionSpacing(13),

          const Text(
            'Send your confidential instructions\n'
            'to your dedicated heritage\n'
            'curator.',
            style: TextStyle(
              color: Color(0xFFD1C7BA),
              fontSize: 14,
              height: 1.65,
            ),
          ),

          _buildSectionSpacing(23),

          const CuratorCard(),

          _buildSectionSpacing(24),

          const ContactSectionLabel(title: 'Request Category'),
          _buildCategoryField(),

          _buildSectionSpacing(17),

          const ContactSectionLabel(
            title: 'Acquisition Reference',
            trailing: 'Optional',
          ),
          _buildReferenceField(),

          _buildSectionSpacing(17),

          const ContactSectionLabel(title: 'Protocol Priority'),
          _buildPrioritySelector(),

          _buildSectionSpacing(18),

          _buildInstructionsCounter(),
          _buildInstructionsField(),

          _buildSectionSpacing(8),
          _buildInstructionsActions(),

          _buildSectionSpacing(23),

          const ContactSectionLabel(title: 'Preferred Response Method'),
          _buildResponseMethods(),

          _buildSectionSpacing(10),

          const CuratorAvailabilityCard(),

          _buildSectionSpacing(17),

          _buildSubmitButton(),

          _buildSectionSpacing(34),

          _buildFooter(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: 'Private Concierge Support',
              isConcierge: true,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final maxContentWidth = width >= 1000
                      ? 720.0
                      : width >= 700
                      ? 680.0
                      : double.infinity;

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: SizedBox(
                        width: double.infinity,
                        child: requestStatus != null
                            ? SupportRequestResult(
                                status: requestStatus!,
                                onTryAgain: _resetRequestForm,
                                onBackToSupport: _resetRequestForm,
                              )
                            : _buildFormContent(width),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
