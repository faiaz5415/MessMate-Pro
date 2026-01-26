import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> todayNotifications = [
      {
        'id': 1,
        'type': 'success',
        'icon': Icons.check_circle_outline,
        'title': 'Join Request Approved',
        'body': 'Your request to join "Green House Mess" has been approved by the manager.',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'id': 2,
        'type': 'info',
        'icon': Icons.article_outlined,
        'title': 'New Notice Posted',
        'body': 'Manager posted: "Meal Rate Adjustment"',
        'time': '5 hours ago',
        'isRead': false,
      },
    ];

    final List<Map<String, dynamic>> yesterdayNotifications = [
      {
        'id': 3,
        'type': 'warning',
        'icon': Icons.lock_clock_outlined,
        'title': 'Meal Lock Applied',
        'body': 'Monthly meal calculation has been locked by the manager.',
        'time': 'Yesterday, 11:30 PM',
        'isRead': true,
      },
      {
        'id': 4,
        'type': 'success',
        'icon': Icons.payments_outlined,
        'title': 'Deposit Confirmed',
        'body': 'Your deposit of ৳500 has been recorded.',
        'time': 'Yesterday, 2:45 PM',
        'isRead': true,
      },
    ];

    final List<Map<String, dynamic>> olderNotifications = [
      {
        'id': 5,
        'type': 'info',
        'icon': Icons.shopping_bag_outlined,
        'title': 'Bazar Added',
        'body': 'Manager added a bazar entry of ৳450.',
        'time': '2 days ago',
        'isRead': true,
      },
      {
        'id': 6,
        'type': 'info',
        'icon': Icons.restaurant_menu_outlined,
        'title': 'Meal Updated',
        'body': 'Your meal count has been updated: +3 meals.',
        'time': '3 days ago',
        'isRead': true,
      },
    ];

    final unreadCount = todayNotifications.where((n) => !n['isRead']).length +
        yesterdayNotifications.where((n) => !n['isRead']).length +
        olderNotifications.where((n) => !n['isRead']).length;

    /// -------------------------------------------

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Notifications',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            if (unreadCount > 0)
              Text(
                '$unreadCount unread',
                style: AppStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        actions: [
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.done_all_outlined),
                tooltip: 'Mark all as read',
                onPressed: () {},
              ),
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: todayNotifications.isEmpty &&
              yesterdayNotifications.isEmpty &&
              olderNotifications.isEmpty
              ? _EmptyState()
              : ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: AppStyles.spaceMedium,
            ),
            children: [
              /// TODAY SECTION
              if (todayNotifications.isNotEmpty) ...[
                _SectionHeader(label: 'Today'),
                ...todayNotifications.map((notification) =>
                    _NotificationCard(notification: notification)),
                const SizedBox(height: AppStyles.spaceLarge),
              ],

              /// YESTERDAY SECTION
              if (yesterdayNotifications.isNotEmpty) ...[
                _SectionHeader(label: 'Yesterday'),
                ...yesterdayNotifications.map((notification) =>
                    _NotificationCard(notification: notification)),
                const SizedBox(height: AppStyles.spaceLarge),
              ],

              /// OLDER SECTION
              if (olderNotifications.isNotEmpty) ...[
                _SectionHeader(label: 'Older'),
                ...olderNotifications.map((notification) =>
                    _NotificationCard(notification: notification)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// SECTION HEADER
/// ------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppStyles.spaceLarge,
        AppStyles.spaceMedium,
        AppStyles.spaceLarge,
        AppStyles.spaceMedium,
      ),
      child: Text(
        label,
        style: AppStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// NOTIFICATION CARD (Timeline Style)
/// ------------------------------------------------------------
class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final isRead = notification['isRead'] as bool;
    final type = notification['type'] as String;
    final iconColor = _getTypeColor(type);

    return Container(
      margin: const EdgeInsets.only(
        left: AppStyles.spaceLarge,
        right: AppStyles.spaceLarge,
        bottom: AppStyles.spaceSmall,
      ),
      child: ModernCard(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        color: isRead ? null : AppColors.primary.withOpacity(0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON CONTAINER
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: iconColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    notification['icon'],
                    color: iconColor,
                    size: 22,
                  ),
                ),

                /// UNREAD INDICATOR
                if (!isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: AppStyles.spaceMedium),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    notification['title'],
                    style: AppStyles.bodyMedium.copyWith(
                      fontWeight: isRead ? FontWeight.w600 : FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// BODY
                  Text(
                    notification['body'],
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceSmall),

                  /// TIME
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 12,
                        color: AppColors.textSecondary.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        notification['time'],
                        style: AppStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// ACTION BUTTON
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.more_vert_rounded,
                  size: 18,
                  color: AppColors.textSecondary.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'success':
        return AppColors.success;
      case 'warning':
        return AppColors.warning;
      case 'error':
        return AppColors.error;
      case 'info':
      default:
        return AppColors.blue;
    }
  }
}

/// ------------------------------------------------------------
/// EMPTY STATE
/// ------------------------------------------------------------
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceXLarge),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 64,
              color: AppColors.primary.withOpacity(0.4),
            ),
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          Text(
            'No Notifications',
            style: AppStyles.heading3.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppStyles.spaceSmall),

          Text(
            'You\'re all caught up!',
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
