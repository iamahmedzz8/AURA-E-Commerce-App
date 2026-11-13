import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/support/faq/data/models/faq_model.dart';
import 'package:aura_maison_e_commerce/features/support/faq/presentation/widgets/faq_widget.dart';
import 'package:flutter/material.dart';

import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';

import '../widgets/faq_category_tabs.dart';
import '../widgets/faq_question_card.dart';
import '../widgets/faq_contact_section.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final TextEditingController _searchController = TextEditingController();

  int selectedCategory = 0;
  int? expandedIndex;

  final List<String> categories = [
    'ALL (8)',
    'ORDERS & CONVOYS (3)',
    'AUTHENTICITY (2)',
    'PAYMENTS (1)',
    'PRIVATE SALON (2)',
  ];

  // Static UI data for now
  final List<FaqModel> questions = [
    FaqModel(
      category: 'ORDERS & CONVOYS',
      question: 'How is personal handover under diplomatic escort arranged?',
      answer:
          'Your timepiece is transported in sealed trunks by our sworn couriers. '
          'You may arrange delivery to a private salon, hotel suite, or your residence. '
          'The handover is completed using a cryptographic signature and identity verification.',
    ),
    FaqModel(
      category: 'AUTHENTICITY',
      question: 'What guarantees the authenticity of my acquisition?',
      answer:
          'Every masterpiece is accompanied by its official documentation and '
          'certificate of authenticity. Our curators can provide further details '
          'about the provenance and verification process upon request.',
    ),
    FaqModel(
      category: 'ORDERS & CONVOYS',
      question: 'How long does a private delivery usually take?',
      answer:
          'Delivery arrangements depend on the destination and the availability '
          'of the selected piece. Your dedicated curator will coordinate the '
          'schedule and keep you informed throughout the process.',
    ),
    FaqModel(
      category: 'PRIVATE SALON',
      question: 'Can I deposit my timepiece in the Genève bonded vault?',
      answer:
          'Yes. Selected timepieces may be deposited in our Genève bonded vault. '
          'Contact your private curator to discuss availability and the required '
          'documentation.',
    ),
    FaqModel(
      category: 'PAYMENTS',
      question: 'Which confidential payment methods are accepted?',
      answer:
          'Our private team will discuss the available confidential payment '
          'arrangements with you. Please contact your curator for details '
          'specific to your acquisition.',
    ),
    FaqModel(
      category: 'PRIVATE SALON',
      question: 'May I arrange a private tour of the Meyrin workshops?',
      answer:
          'Private workshop visits can be arranged by appointment, subject to '
          'availability. Your curator will help coordinate a suitable date '
          'and provide the visit details.',
    ),
    FaqModel(
      category: 'ORDERS & CONVOYS',
      question: 'Can I change my delivery destination?',
      answer:
          'Please contact your curator before dispatch. Any change to the '
          'destination must be reviewed and confirmed according to the '
          'applicable delivery protocol.',
    ),
    FaqModel(
      category: 'AUTHENTICITY',
      question: 'Will I receive documentation with my timepiece?',
      answer:
          'The documentation provided depends on the individual piece. '
          'Your curator can confirm the accompanying certificates and '
          'records before your acquisition is finalized.',
    ),
  ];

  List<FaqModel> get filteredQuestions {
    final query = _searchController.text.trim().toLowerCase();

    const categoryFilters = [
      null,
      'ORDERS & CONVOYS',
      'AUTHENTICITY',
      'PAYMENTS',
      'PRIVATE SALON',
    ];

    final selectedFilter = categoryFilters[selectedCategory];

    return questions.where((item) {
      final matchesSearch =
          item.question.toLowerCase().contains(query) ||
          item.answer.toLowerCase().contains(query);

      final matchesCategory =
          selectedFilter == null || item.category == selectedFilter;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      expandedIndex = null;
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedCategory = index;
      expandedIndex = null;
    });
  }

  void _onQuestionTapped(int index) {
    setState(() {
      expandedIndex = expandedIndex == index ? null : index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedQuestions = filteredQuestions;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FaqSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),

            SliverToBoxAdapter(child: _buildProtocolHeader()),

            SliverToBoxAdapter(
              child: FaqCategoryTabs(
                categories: categories,
                selectedIndex: selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),

            SliverToBoxAdapter(
              child: _buildQuestionsHeader(displayedQuestions.length),
            ),

            SliverToBoxAdapter(child: _buildQuestionsList(displayedQuestions)),

            SliverToBoxAdapter(
              child: FaqContactSection(
                onContactPressed: () {
                  // TODO: Navigate to Concierge Contact Form.
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const AppHeader(
      title: AppStrings.privateConciergeSupport,
      isConcierge: true,
    );
  }

  Widget _buildProtocolHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.goldAccent,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 9),

              Text(
                AppStrings.protocolRegister,
                style: AppStyles.sectionEyebrow.copyWith(
                  color: AppColors.goldAccent,
                  letterSpacing: 1.6,
                  fontSize: 10,
                ),
              ),

              const Spacer(),

              Flexible(
                child: Text(
                  AppStrings.geneveParisLondres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: AppStyles.cardSubtitle.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(height: 1, color: AppColors.headerDivider),
        ],
      ),
    );
  }

  Widget _buildQuestionsHeader(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 15),
      child: Row(
        children: [
          Text(
            AppStrings.theRegister,
            style: AppStyles.sectionEyebrow.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),

          const Spacer(),

          Text(
            '$count ${AppStrings.articlesUpper}',
            style: AppStyles.sectionCount.copyWith(color: AppColors.goldAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsList(List<FaqModel> items) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(35),
        child: Center(
          child: Text(
            AppStrings.noProtocolsFound,
            style: AppStyles.cardSubtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return FaqQuestionCard(
            question: item.question,
            answer: item.answer,
            isExpanded: expandedIndex == index,
            onTap: () => _onQuestionTapped(index),
          );
        }),
      ),
    );
  }
}
