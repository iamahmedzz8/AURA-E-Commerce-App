import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class ValuationSection extends StatefulWidget {
  const ValuationSection({super.key});

  @override
  State<ValuationSection> createState() => _ValuationSectionState();
}

class _ValuationSectionState extends State<ValuationSection> {
  int stockCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.monetization_on_outlined, color: DarkTheme.gold, size: 16),
              SizedBox(width: 8),
              Text('VALUATION & VAULT AVAILABILITY', style: TextStyle(color: DarkTheme.primaryText, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SALE PRICE EXCL. TAX (€)', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, letterSpacing: 1, fontFamily: 'Inter')),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: DarkTheme.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: DarkTheme.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond'),
                              decoration: const InputDecoration(
                                hintText: '165 000',
                                hintStyle: TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond'),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Text('EUR', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 12, fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PATRON DISCOUNT (%)', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, letterSpacing: 1, fontFamily: 'Inter')),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: DarkTheme.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: DarkTheme.border),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('0', style: TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond')),
                          SizedBox(height: 2),
                          Text('0% STRICT', style: TextStyle(color: Colors.redAccent, fontSize: 8, fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available Vault\nStock', style: TextStyle(color: DarkTheme.primaryText, fontSize: 12, fontFamily: 'Inter', height: 1.4)),
                  SizedBox(height: 4),
                  Text('Vendôme Vault Room IV', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, fontFamily: 'Inter')),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16, color: DarkTheme.primaryText),
                      onPressed: () {
                        if (stockCount > 0) setState(() => stockCount--);
                      },
                    ),
                    Text('$stockCount', style: const TextStyle(color: DarkTheme.gold, fontSize: 16, fontFamily: 'EB Garamond')),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16, color: DarkTheme.primaryText),
                      onPressed: () => setState(() => stockCount++),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}