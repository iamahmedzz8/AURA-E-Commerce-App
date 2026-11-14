import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SegmentedAccessModeSwitch extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const SegmentedAccessModeSwitch({
    super.key,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  State<SegmentedAccessModeSwitch> createState() =>
      _SegmentedAccessModeSwitchState();
}

class _SegmentedAccessModeSwitchState extends State<SegmentedAccessModeSwitch> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.badgeBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.chipBorder, width: 0.5),
        ),
        child: Row(
          children: [
            // Tab 1: PATRON SIGN IN
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() => _selectedIndex = 0);
                  widget.onTabChanged?.call(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      AppStrings.patronSignInTab,
                      style: AppStyles.accessModeTab.copyWith(
                        color: _selectedIndex == 0
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 86,
                      height: 2,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? AppColors.goldAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab 2: PRIVATE REGISTER
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() => _selectedIndex = 1);
                  widget.onTabChanged?.call(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      AppStrings.privateRegisterTab,
                      style: AppStyles.accessModeTab.copyWith(
                        color: _selectedIndex == 1
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 86,
                      height: 2,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? AppColors.goldAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
