import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by reference, caliber, name...',
                    prefixIcon: Icon(Icons.search, color: textTheme.bodyMedium?.color, size: 18),
                    contentPadding:  EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                ),
              ),
               SizedBox(width: 8),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: theme.dividerTheme.color ?? Colors.grey),
                ),
                child: Icon(Icons.filter_list, color: textTheme.bodyMedium?.color, size: 18),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _buildChip(context, 'ALL (48)', isActive: true),
               SizedBox(width: 8),
              _buildChip(context, 'IN VAULT (32)'),
               SizedBox(width: 8),
              _buildChip(context, 'ALLOCATED (12)'),
               SizedBox(width: 8),
              _buildChip(context, 'OUT OF...'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label, {bool isActive = false}) {
    final theme = Theme.of(context);
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? theme.colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? theme.colorScheme.primary : (theme.dividerTheme.color ?? Colors.grey),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: isActive ? theme.colorScheme.onPrimary : theme.textTheme.bodyMedium?.color,
          fontSize: 10,
        ),
      ),
    );
  }
}