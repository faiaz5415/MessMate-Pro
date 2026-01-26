import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../models/notification_model.dart';

class NotificationsPopup extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(String) onMarkAsRead;
  final VoidCallback onMarkAllAsRead;
  final Function(String) onDelete;

  const NotificationsPopup({
    super.key,
    required this.notifications,
    required this.onMarkAsRead,
    required this.onMarkAllAsRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.border.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                /// DRAG HANDLE
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// TITLE & ACTIONS
                Row(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: AppStyles.spaceSmall),
                    Text(
                      'Notifications',
                      style: AppStyles.heading3.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (unreadCount > 0) ...[
                      const SizedBox(width: AppStyles.spaceSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (unreadCount > 0)
                      TextButton(
                        onPressed: onMarkAllAsRead,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.done_all,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            const Text('Read All'),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          /// NOTIFICATIONS LIST
          Expanded(
            child: notifications.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: AppColors.textSecondary.withOpacity(0.3),
                  ),
                  const SizedBox(height: AppStyles.spaceMedium),
                  Text(
                    'No notifications',
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: AppStyles.spaceSmall,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    onDelete(notification.id);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: AppColors.error,
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  child: _NotificationTile(
                    notification: notification,
                    onTap: () {
                      if (!notification.isRead) {
                        onMarkAsRead(notification.id);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// NOTIFICATION TILE
/// ------------------------------------------------------------
class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  IconData _getNotificationIcon(String title) {
    if (title.contains('Payment')) return Icons.payments_outlined;
    if (title.contains('Bazar')) return Icons.shopping_bag_outlined;
    if (title.contains('Meal')) return Icons.restaurant_menu_outlined;
    if (title.contains('Welcome')) return Icons.celebration_outlined;
    return Icons.notifications_outlined;
  }

  Color _getNotificationColor(String title) {
    if (title.contains('Payment')) return AppColors.error;
    if (title.contains('Bazar')) return AppColors.orange;
    if (title.contains('Meal')) return AppColors.blue;
    if (title.contains('Welcome')) return AppColors.success;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getNotificationColor(notification.title);
    final icon = _getNotificationIcon(notification.title);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        margin: const EdgeInsets.symmetric(
          horizontal: AppStyles.spaceMedium,
          vertical: AppStyles.spaceSmall / 2,
        ),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.surface
              : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? AppColors.border.withOpacity(0.3)
                : color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),

            const SizedBox(width: AppStyles.spaceMedium),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: notification.isRead
                                ? AppColors.textPrimary.withOpacity(0.6)
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: AppStyles.bodySmall.copyWith(
                      color: notification.isRead
                          ? AppColors.textSecondary.withOpacity(0.6)
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    timeago.format(notification.timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
