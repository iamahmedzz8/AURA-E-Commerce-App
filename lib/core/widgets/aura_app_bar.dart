import 'package:flutter/material.dart';

class AuraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const AuraAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark ? Colors.white : const Color(0xFF1C1C1C);

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: foreground,
          size: 20,
        ),
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: foreground,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}