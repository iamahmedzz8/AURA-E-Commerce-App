import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../inventory/presentation/screens/inventory_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'ORDERS & WATCHMAKING DECREES',
          style: TextStyle(
            color: DarkTheme.secondaryText,
            fontSize: 10,
            letterSpacing: 1.5,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
         SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: DarkTheme.gold,
              foregroundColor: DarkTheme.background,
              padding:  EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
            ),
            onPressed: () => Navigator.pushNamed(context, '/add-product'),
            icon:  Icon(Icons.add_circle_outline, size: 18),
            label:  Text(
              'REGISTER A MASTERPIECE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
         SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: DarkTheme.surface,
              foregroundColor: DarkTheme.primaryText,
              side:  BorderSide(color: DarkTheme.border),
              padding:  EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () => Navigator.push((context),
                MaterialPageRoute(builder:
                (context)=>InventoryScreen(),
                )),
            icon:  Icon(Icons.grid_view, size: 18, color: DarkTheme.gold),
            label:  Text(
              'MANAGE INVENTORY REGISTER',
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: DarkTheme.surface.withOpacity(0.5),
              foregroundColor: DarkTheme.secondaryText,
              padding:  EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: DarkTheme.border.withOpacity(0.5)),
              ),
            ),
            onPressed: () {},
            icon:  Icon(Icons.settings_outlined, size: 16),
            label:  Text(
              'GENERATE NOTARIZED COSC REPORT',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}