import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Join Request Approved',
        'message': 'Welcome to Green House Mess!',
        'time': '2 hours ago',
        'isRead': false,
        'type': 'success',
      },
      {
        'title': 'Meal Locked',
        'message': 'Day 15 meals have been locked by manager.',
        'time': '5 hours ago',
        'isRead': false,
        'type': 'info',
      },
      {
        'title': 'New Notice Posted',
        'message': 'Meal Rate Updated - Check notices.',
        'time': 'Yesterday',
        'isRead': true,
        'type': 'warning',
      },
      {
        'title': 'Deposit Reminder',
        'message': 'Please submit your monthly deposit.',
        'time': '2 days ago',
        'isRead': true,
        'type': 'info',
      },
    ];

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(
              'Mark All Read',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _NotificationCard(
            title: notification['title'],
            message: notification['message'],
            time: notification['time'],
            isRead: notification['isRead'],
            type: notification['type'],
          );
        },
      ),
    );
  }
}

/// NOTIFICATION CARD
class _NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final String type; // success, info, warning, error

  const _NotificationCard({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _getTypeColor();
    final IconData typeIcon = _getTypeIcon();

    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceSmall),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      color: isRead
          ? AppColors.cardBackground
          : AppColors.primary.withOpacity(0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceSmall),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
              size: 20,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: AppStyles.spaceXSmall),

                Text(
                  message,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                Text(
                  time,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor() {
    switch (type) {
      case 'success':
        return AppColors.success;
      case 'warning':
        return AppColors.warning;
      case 'error':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case 'success':
        return Icons.check_circle_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'error':
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }
}
