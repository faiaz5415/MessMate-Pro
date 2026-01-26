import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    /// Later these will come from Provider / Firebase

    final bool youHaveToPay = true; // false হলে receive
    final double balanceAmount = 350;

    final int totalMeals = 189;
    final double mealRate = 65;
    final double yourCost = 1950;
    final double totalMessCost = 12300;

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PAY / RECEIVE CARD
            _BalanceStatusCard(
              isPay: youHaveToPay,
              amount: balanceAmount,
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// Section Title
            Text(
              'Month Overview',
              style: AppStyles.heading3,
            ),

            const SizedBox(height: AppStyles.spaceMedium),

            /// SUMMARY GRID
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppStyles.spaceMedium,
              mainAxisSpacing: AppStyles.spaceMedium,
              childAspectRatio: 1.1,
              children: [
                _MetricCard(
                  title: 'Total Meals',
                  value: totalMeals.toString(),
                  icon: Icons.restaurant_menu,
                  color: AppColors.orange,
                ),
                _MetricCard(
                  title: 'Meal Rate',
                  value: '৳$mealRate',
                  icon: Icons.attach_money,
                  color: AppColors.blue,
                ),
                _MetricCard(
                  title: 'Your Cost',
                  value: '৳$yourCost',
                  icon: Icons.person_outline,
                  color: AppColors.purple,
                ),
                _MetricCard(
                  title: 'Total Cost',
                  value: '৳$totalMessCost',
                  icon: Icons.account_balance_wallet_outlined,
                  color: AppColors.teal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PAY / RECEIVE CARD
/// ------------------------------------------------------------
class _BalanceStatusCard extends StatelessWidget {
  final bool isPay;
  final double amount;

  const _BalanceStatusCard({
    required this.isPay,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isPay ? AppColors.error : AppColors.success;
    final IconData statusIcon = isPay ? Icons.arrow_upward : Icons.arrow_downward;
    final String statusText = isPay ? 'You Have To Pay' : 'You Will Receive';

    return ModernCard(
      padding: const EdgeInsets.all(AppStyles.spaceLarge),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceMedium),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 32,
            ),
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          Text(
            statusText,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppStyles.spaceSmall),

          Text(
            '৳${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// METRIC CARD
/// ------------------------------------------------------------
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      decoration: AppStyles.coloredCardDecoration(color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(AppStyles.spaceSmall),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            title,
            style: AppStyles.caption.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppStyles.spaceXSmall),

          Text(
            value,
            style: AppStyles.heading3.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
