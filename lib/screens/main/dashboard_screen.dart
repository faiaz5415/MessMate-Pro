import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/notifications_popup.dart';
import '../../models/notification_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Mock notifications data
  late List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'Payment Reminder',
        body: 'Your monthly payment of ৳350 is due',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'New Bazar Entry',
        body: 'Karim added bazar cost: ৳450',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Meal Rate Updated',
        body: 'New meal rate: ৳65 per meal',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Welcome!',
        body: 'Welcome to MessMate Pro',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
      ),
    ];
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n.id == notificationId);
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      _notifications.removeWhere((n) => n.id == notificationId);
    });
  }

  void _showNotificationsPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NotificationsPopup(
        notifications: _notifications,
        onMarkAsRead: _markAsRead,
        onMarkAllAsRead: _markAllAsRead,
        onDelete: _deleteNotification,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final bool youHaveToPay = true;
    final double balanceAmount = 350;
    final int totalMeals = 189;
    final double mealRate = 65;
    final double yourCost = 1950;
    final double totalMessCost = 12300;
    /// -------------------------------------------

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'MessMate',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'January 2026',
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
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
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () => _showNotificationsPopup(context),
                ),
                // Unread badge
                if (_unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          _unreadCount > 9 ? '9+' : '$_unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppStyles.spaceMedium),

                /// HERO BALANCE CARD
                _HeroBalanceCard(
                  isPay: youHaveToPay,
                  amount: balanceAmount,
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// SECTION HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: AppStyles.spaceSmall),
                      Text(
                        'Month Insights',
                        style: AppStyles.heading3.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// STATS GRID
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Column(
                    children: [
                      /// TOP ROW (2 CARDS)
                      Row(
                        children: [
                          Expanded(
                            child: _ModernStatCard(
                              title: 'Total Meals',
                              value: totalMeals.toString(),
                              icon: Icons.restaurant_menu_outlined,
                              color: AppColors.orange,
                              trend: '+12',
                            ),
                          ),
                          const SizedBox(width: AppStyles.spaceMedium),
                          Expanded(
                            child: _ModernStatCard(
                              title: 'Meal Rate',
                              value: '৳$mealRate',
                              icon: Icons.trending_up_outlined,
                              color: AppColors.blue,
                              trend: '-৳5',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppStyles.spaceMedium),

                      /// BOTTOM ROW (2 CARDS)
                      Row(
                        children: [
                          Expanded(
                            child: _ModernStatCard(
                              title: 'Your Cost',
                              value: '৳$yourCost',
                              icon: Icons.account_balance_wallet_outlined,
                              color: AppColors.purple,
                            ),
                          ),
                          const SizedBox(width: AppStyles.spaceMedium),
                          Expanded(
                            child: _ModernStatCard(
                              title: 'Total Cost',
                              value: '৳$totalMessCost',
                              icon: Icons.receipt_long_outlined,
                              color: AppColors.teal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// QUICK ACTIONS
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppStyles.spaceMedium),
                      Row(
                        children: [
                          _QuickActionButton(
                            icon: Icons.add_circle_outline,
                            label: 'Add Meal',
                            color: AppColors.success,
                            onTap: () {},
                          ),
                          const SizedBox(width: AppStyles.spaceMedium),
                          _QuickActionButton(
                            icon: Icons.shopping_bag_outlined,
                            label: 'Add Bazar',
                            color: AppColors.orange,
                            onTap: () {},
                          ),
                          const SizedBox(width: AppStyles.spaceMedium),
                          _QuickActionButton(
                            icon: Icons.payments_outlined,
                            label: 'Deposit',
                            color: AppColors.blue,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// HERO BALANCE CARD (The Showstopper)
/// ------------------------------------------------------------
class _HeroBalanceCard extends StatelessWidget {
  final bool isPay;
  final double amount;

  const _HeroBalanceCard({
    required this.isPay,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isPay ? AppColors.error : AppColors.success;
    final IconData statusIcon = isPay ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final String statusText = isPay ? 'You Need To Pay' : 'You Will Receive';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
      child: Stack(
        children: [
          /// BACKGROUND CARD WITH GRADIENT
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppStyles.spaceXLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  statusColor,
                  statusColor.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// STATUS ICON
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    statusIcon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// STATUS TEXT
                Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                /// AMOUNT
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '৳',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      amount.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// ACTION BUTTON
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isPay ? 'Pay Now' : 'View Details',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// FLOATING BADGE
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// MODERN STAT CARD (Fintech Style)
/// ------------------------------------------------------------
class _ModernStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? trend;

  const _ModernStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON & TREND
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: trend!.startsWith('+')
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    trend!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: trend!.startsWith('+')
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          /// TITLE
          Text(
            title,
            style: AppStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 4),

          /// VALUE
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// QUICK ACTION BUTTON
/// ------------------------------------------------------------
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 22,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
