import 'package:aura_maison_e_commerce/core/theme/aura_theme.dart';
import 'package:aura_maison_e_commerce/features/notification/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// + import الـ NotificationModel

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.notifications_outlined)),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.notificationText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: notification.isRead
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  notification.createdAt.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (!notification.isRead) ...[
            const Gap(10),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AuraTheme.lightTheme.iconTheme.color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
