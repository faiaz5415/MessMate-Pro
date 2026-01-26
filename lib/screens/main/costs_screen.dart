import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class CostsScreen extends StatefulWidget {
  const CostsScreen({super.key});

  @override
  State<CostsScreen> createState() => _CostsScreenState();
}

class _CostsScreenState extends State<CostsScreen> {
  String _selectedMonth = 'January 2026';

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final bool youHaveToPay = true;
    final double balanceAmount = 350;

    final double mealCost = 1950;
    final double bazarContribution = 658;
    final double otherCosts = 150;
    final double totalDeposit = 2408;

    final List<Map<String, dynamic>> deposits = [
      {'date': '20 Jan', 'amount': 500.0, 'time': '2:30 PM'},
      {'date': '10 Jan', 'amount': 1000.0, 'time': '10:15 AM'},
      {'date': '1 Jan', 'amount': 908.0, 'time': '6:45 PM'},
    ];

    /// -------------------------------------------

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (youHaveToPay ? AppColors.error : AppColors.success)
                  .withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// APP BAR
                Padding(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Costs & Balance',
                            style: AppStyles.heading3.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _selectedMonth,
                            style: AppStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
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
                          icon: const Icon(Icons.calendar_month_outlined),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),

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
                        'Cost Breakdown',
                        style: AppStyles.heading3.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// COST BREAKDOWN CARDS
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Column(
                    children: [
                      _CostBreakdownCard(
                        icon: Icons.restaurant_menu_outlined,
                        label: 'Meal Cost',
                        amount: mealCost,
                        color: AppColors.purple,
                        subtitle: '189 meals × ৳65',
                      ),
                      const SizedBox(height: AppStyles.spaceSmall),
                      _CostBreakdownCard(
                        icon: Icons.shopping_bag_outlined,
                        label: 'Bazar Share',
                        amount: bazarContribution,
                        color: AppColors.orange,
                        subtitle: '20% of total bazar',
                      ),
                      const SizedBox(height: AppStyles.spaceSmall),
                      _CostBreakdownCard(
                        icon: Icons.receipt_long_outlined,
                        label: 'Other Costs',
                        amount: otherCosts,
                        color: AppColors.blue,
                        subtitle: 'Gas, electricity, etc.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// DEPOSITS SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Deposits',
                        style: AppStyles.heading3.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '৳${totalDeposit.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// DEPOSIT TIMELINE
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Column(
                    children: deposits.map((deposit) {
                      return _DepositTimelineItem(
                        date: deposit['date'],
                        amount: deposit['amount'],
                        time: deposit['time'],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Deposit'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

/// ------------------------------------------------------------
/// HERO BALANCE CARD (Emotional Clarity)
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
    final IconData statusIcon = isPay
        ? Icons.arrow_upward_rounded
        : Icons.arrow_downward_rounded;
    final String statusText = isPay ? 'You Need To Pay' : 'You Will Receive';
    final String actionText = isPay ? 'PAY NOW' : 'DETAILS';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
      child: Stack(
        children: [
          /// MAIN CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppStyles.spaceXLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  statusColor,
                  statusColor.withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
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
                        fontSize: 28,
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

                const SizedBox(height: AppStyles.spaceLarge),

                /// ACTION BUTTON
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionText,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// PULSE INDICATOR
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
                  Text(
                    isPay ? 'DUE' : 'CREDIT',
                    style: const TextStyle(
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
/// COST BREAKDOWN CARD
/// ------------------------------------------------------------
class _CostBreakdownCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;
  final Color color;
  final String subtitle;

  const _CostBreakdownCard({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppStyles.spaceSmall),

          /// AMOUNT
          Text(
            '৳${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 18,
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
/// DEPOSIT TIMELINE ITEM
/// ------------------------------------------------------------
class _DepositTimelineItem extends StatelessWidget {
  final String date;
  final double amount;
  final String time;

  const _DepositTimelineItem({
    required this.date,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceSmall),
      child: Row(
        children: [
          /// TIMELINE DOT
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.success.withOpacity(0.3),
                    width: 3,
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 40,
                color: AppColors.border,
              ),
            ],
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          /// CARD
          Expanded(
            child: ModernCard(
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              color: AppColors.success.withOpacity(0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '৳${amount.toStringAsFixed(0)}',
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$date • $time',
                        style: AppStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 20,
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
