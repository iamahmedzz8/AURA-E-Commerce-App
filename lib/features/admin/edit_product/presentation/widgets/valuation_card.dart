import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class ValuationCard extends StatelessWidget {
  const ValuationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.account_balance_outlined,
              color: DarkTheme.gold,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Valuation & Vault Availability',
              style: TextStyle(
                color: DarkTheme.primaryText,
                fontSize: 20,
                fontFamily: 'EB Garamond',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ACQUISITION PRICE (VENDÔME VAT INCLUDED)',
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 9,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '142 000 €',
                      style: TextStyle(
                        color: DarkTheme.gold,
                        fontSize: 24,
                        fontFamily: 'EB Garamond',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.monetization_on_outlined,
                      color: DarkTheme.secondaryText,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'PRIVATE ALLOCATION STATUS',
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 9,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: DarkTheme.surface,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: DarkTheme.gold,
                      size: 18,
                    ),
                    hint: const Text(
                      'Available at Vendôme Salon',
                      style: TextStyle(
                        color: DarkTheme.primaryText,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    items: const [],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'UNITS IN ARMORED VAULT',
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 9,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2 numbered pieces: 04/08, 05/08',
                      style: TextStyle(
                        color: DarkTheme.primaryText,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Icon(
                      Icons.inventory_2_outlined,
                      color: DarkTheme.gold,
                      size: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Strict edition: 8 pieces worldwide',
                    style: TextStyle(
                      color: DarkTheme.secondaryText.withValues(alpha: 0.7),
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Workshop quota: 25%',
                    style: TextStyle(
                      color: DarkTheme.gold,
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
