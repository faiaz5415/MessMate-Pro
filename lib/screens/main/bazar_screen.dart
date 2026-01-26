import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class BazarScreen extends StatefulWidget {
  const BazarScreen({super.key});

  @override
  State<BazarScreen> createState() => _BazarScreenState();
}

class _BazarScreenState extends State<BazarScreen> {
  String _selectedMonth = 'January 2026';

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> bazarItems = [
      {
        'title': 'Chicken & Rice',
        'date': '12 Jan 2026',
        'buyer': 'Karim',
        'amount': 450.0,
        'time': '10:30 AM'
      },
      {
        'title': 'Vegetables',
        'date': '11 Jan 2026',
        'buyer': 'Rahim',
        'amount': 280.0,
        'time': '8:15 AM'
      },
      {
        'title': 'Fish & Spices',
        'date': '10 Jan 2026',
        'buyer': 'You',
        'amount': 520.0,
        'time': '6:45 PM'
      },
      {
        'title': 'Fruits & Eggs',
        'date': '9 Jan 2026',
        'buyer': 'Karim',
        'amount': 310.0,
        'time': '9:20 AM'
      },
      {
        'title': 'Meat & Dal',
        'date': '8 Jan 2026',
        'buyer': 'Rahim',
        'amount': 480.0,
        'time': '7:30 AM'
      },
      {
        'title': 'Oil & Groceries',
        'date': '7 Jan 2026',
        'buyer': 'You',
        'amount': 650.0,
        'time': '11:00 AM'
      },
      {
        'title': 'Snacks & Drinks',
        'date': '6 Jan 2026',
        'buyer': 'Karim',
        'amount': 220.0,
        'time': '3:45 PM'
      },
      {
        'title': 'Rice & Lentils',
        'date': '5 Jan 2026',
        'buyer': 'Rahim',
        'amount': 380.0,
        'time': '8:00 AM'
      },
    ];

    final double totalBazar = bazarItems.fold(
      0,
          (sum, item) => sum + (item['amount'] as double),
    );

    final int totalTransactions = bazarItems.length;
    final double avgTransaction = totalBazar / totalTransactions;

    /// -------------------------------------------

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Bazar Log',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              _selectedMonth,
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
            child: IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: () {
                // Month selector
              },
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
              AppColors.orange.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppStyles.spaceMedium),

              /// HERO BAZAR SUMMARY
              _HeroBazarSummary(
                totalBazar: totalBazar,
                totalTransactions: totalTransactions,
                avgTransaction: avgTransaction,
              ),

              const SizedBox(height: AppStyles.spaceLarge),

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
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: AppStyles.spaceSmall),
                    Text(
                      'Transactions',
                      style: AppStyles.heading3.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$totalTransactions total',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              /// BAZAR LIST
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppStyles.spaceLarge,
                    0,
                    AppStyles.spaceLarge,
                    AppStyles.spaceLarge,
                  ),
                  itemCount: bazarItems.length,
                  itemBuilder: (context, index) {
                    final item = bazarItems[index];
                    return _BazarTransactionCard(
                      title: item['title'],
                      date: item['date'],
                      buyer: item['buyer'],
                      amount: item['amount'],
                      time: item['time'],
                      isYou: item['buyer'] == 'You',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add bazar (manager only)
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Bazar'),
        backgroundColor: AppColors.orange,
      ),
    );
  }
}

/// ------------------------------------------------------------
/// HERO BAZAR SUMMARY (Focus Zone)
/// ------------------------------------------------------------
class _HeroBazarSummary extends StatelessWidget {
  final double totalBazar;
  final int totalTransactions;
  final double avgTransaction;

  const _HeroBazarSummary({
    required this.totalBazar,
    required this.totalTransactions,
    required this.avgTransaction,
  });

  @override
  Widget build(BuildContext context) {
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
                  AppColors.orange,
                  AppColors.orange.withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// LABEL
                const Text(
                  'Total Bazar Cost',
                  style: TextStyle(
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
                      totalBazar.toStringAsFixed(0),
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

                /// STATS ROW
                Row(
                  children: [
                    _MiniStat(
                      label: 'Avg/Purchase',
                      value: '৳${avgTransaction.toStringAsFixed(0)}',
                    ),
                    const SizedBox(width: AppStyles.spaceLarge),
                    _MiniStat(
                      label: 'This Month',
                      value: '$totalTransactions buys',
                    ),
                  ],
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
                    'TRACKED',
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

/// MINI STAT
class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// ------------------------------------------------------------
/// BAZAR TRANSACTION CARD (Flow Zone)
/// ------------------------------------------------------------
class _BazarTransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final String buyer;
  final double amount;
  final String time;
  final bool isYou;

  const _BazarTransactionCard({
    required this.title,
    required this.date,
    required this.buyer,
    required this.amount,
    required this.time,
    required this.isYou,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.orange.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.orange,
              size: 24,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title,
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                /// BUYER & DATE ROW
                Row(
                  children: [
                    /// BUYER BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isYou
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        buyer,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isYou ? AppColors.success : AppColors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    /// DATE
                    Text(
                      '$date • $time',
                      style: AppStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: AppStyles.spaceSmall),

          /// AMOUNT
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.orange,
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textSecondary.withOpacity(0.4),
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
