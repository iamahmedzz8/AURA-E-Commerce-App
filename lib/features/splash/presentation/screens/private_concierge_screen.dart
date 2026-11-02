import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/concierge_data.dart';
import '../../data/models/advisor_model.dart';
import '../../data/models/concierge_service_model.dart';
import '../widgets/advisor_card.dart';
import '../widgets/concierge_editorial_header.dart';
import '../widgets/concierge_filter_bar.dart';
import '../widgets/concierge_service_card.dart';
import '../widgets/concierge_top_bar.dart';

/// Private Concierge Screen (Pillar III: Bespoke Service)
/// Features interactive category filtering and a decoupled data model.
class PrivateConciergeScreen extends StatefulWidget {
  const PrivateConciergeScreen({super.key});

  @override
  State<PrivateConciergeScreen> createState() => _PrivateConciergeScreenState();
}

class _PrivateConciergeScreenState extends State<PrivateConciergeScreen> {
  String _selectedCategoryKey = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // You can easily change the active advisor here or in ConciergeData
  int _activeAdvisorIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ConciergeServiceModel> get _filteredServices {
    return ConciergeData.services.where((service) {
      final matchesCategory =
          _selectedCategoryKey == 'all' ||
          service.category == _selectedCategoryKey;

      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          service.title.toLowerCase().contains(query) ||
          service.description.toLowerCase().contains(query) ||
          service.location.toLowerCase().contains(query) ||
          service.tag.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final activeAdvisor = ConciergeData.advisors[_activeAdvisorIndex];
    final displayedServices = _filteredServices;

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Column(
          children: [
            const ConciergeTopBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ConciergeEditorialHeader(),
                    const SizedBox(height: 20),
                    _buildAdvisorSection(activeAdvisor),
                    const SizedBox(height: 24),
                    _buildFilterSection(displayedServices.length),
                    const SizedBox(height: 14),
                    _buildServicesList(displayedServices),
                    const SizedBox(height: 28),
                    _buildBottomActionButtons(context),
                    const SizedBox(height: 16),
                    _buildFootnoteGuarantee(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvisorSection(AdvisorModel advisor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ASSIGNED DIPLOMATIC LIAISON',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            if (ConciergeData.advisors.length > 1)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _activeAdvisorIndex =
                        (_activeAdvisorIndex + 1) %
                        ConciergeData.advisors.length;
                  });
                },
                child: const Row(
                  children: [
                    Text(
                      'CHANGE ADVISOR',
                      style: TextStyle(
                        color: AppColors.luxuryMuted,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.swap_horiz, size: 14, color: AppColors.gold),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        AdvisorCard(advisor: advisor),
      ],
    );
  }

  Widget _buildFilterSection(int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'EXCLUSIVE SERVICES INCLUDED',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.obsidianCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.obsidianBorder),
              ),
              child: Text(
                '$count privileges',
                style: const TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Search field
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.obsidianCard,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.obsidianBorder),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: AppColors.ivory, fontSize: 13),
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Search bespoke privileges or locations...',
              hintStyle: const TextStyle(
                color: AppColors.luxuryMuted,
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 18,
                color: AppColors.gold,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.luxuryMuted,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Horizontal filter bar
        ConciergeFilterBar(
          filters: ConciergeData.filterCategories,
          selectedCategoryKey: _selectedCategoryKey,
          onSelected: (key) {
            setState(() => _selectedCategoryKey = key);
          },
        ),
      ],
    );
  }

  Widget _buildServicesList(List<ConciergeServiceModel> services) {
    if (services.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 36,
              color: AppColors.gold.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'No bespoke services found matching your filter.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.luxuryMuted, fontSize: 13),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCategoryKey = 'all';
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              child: const Text(
                'Reset Filters',
                style: TextStyle(color: AppColors.gold),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: services.map((service) {
        return ConciergeServiceCard(
          service: service,
          onTap: () {
            _showServiceDetailsSheet(context, service);
          },
        );
      }).toList(),
    );
  }

  void _showServiceDetailsSheet(
    BuildContext context,
    ConciergeServiceModel service,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.obsidianDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.obsidianBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      service.tag,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    service.location,
                    style: const TextStyle(
                      color: AppColors.luxuryMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                service.title,
                style: const TextStyle(
                  fontFamily: 'serif',
                  color: AppColors.ivory,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                service.description,
                style: const TextStyle(
                  color: AppColors.ivoryMuted,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.obsidianDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    'REQUEST PRIVILEGE ALLOCATION',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.obsidianDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 4,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            child: const Text(
              'CREATE A PRIVILEGE ACCOUNT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ivory,
              side: const BorderSide(color: AppColors.gold, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text(
              'ALREADY A MEMBER? SIGN IN',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFootnoteGuarantee() {
    return const Center(
      child: Text(
        'CONFIDENTIAL ACCREDITATION COMPLIANT WITH FINE WATCHMAKING',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.luxuryMuted,
          fontSize: 9,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
