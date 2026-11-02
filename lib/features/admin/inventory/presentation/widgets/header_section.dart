import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back, color: DarkTheme.gold, size: 20),),
           SizedBox(width: 8),
           Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'WORKSHOP MANAGEMENT',
                        style: TextStyle(
                          color: DarkTheme.gold,
                          fontSize: 9,
                          letterSpacing: 1,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10),
                    _VendorBadge(),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'Calibre Inventory',
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 18,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'ROLE: WORKSHOP MANAGER',
                  style: TextStyle(
                    color: DarkTheme.secondaryText,
                    fontSize: 8,
                    letterSpacing: 0.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

           SizedBox(width: 8),
           Icon(Icons.assignment_outlined, color: DarkTheme.secondaryText, size: 20),
           SizedBox(width: 8),
           CircleAvatar(
            radius: 14,
            backgroundColor: DarkTheme.gold,
            child: Icon(Icons.person, size: 16, color: DarkTheme.background),
          ),
        ],
      ),
    );
  }
}

class _VendorBadge extends StatelessWidget {
  const _VendorBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: DarkTheme.border),
      ),
      child:  Text(
        'VENDÔME',
        style: TextStyle(
          color: DarkTheme.gold,
          fontSize: 7,
          letterSpacing: 0.5,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}