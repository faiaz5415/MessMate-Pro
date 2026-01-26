import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class BazarScreen extends StatelessWidget {
  const BazarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> bazarItems = [
      {'title': 'Chicken & Rice', 'date': '12 Jan 2026', 'amount': 450.0},
      {'title': 'Vegetables', 'date': '11 Jan 2026', 'amount': 280.0},
      {'title': 'Fish & Spices', 'date': '10 Jan 2026', 'amount': 520.0},
      {'title': 'Fruits & Eggs', 'date': '9 Jan 2026', 'amount': 310.0},
      {'title': 'Meat & Dal', 'date': '8 Jan 2026', 'amount': 480.0},
      {'title': 'Oil & Groceries', 'date': '7 Jan 2026', 'amount': 650.0},
      {'title': 'Snacks & Drinks', 'date': '6 Jan 2026', 'amount': 220.0},
      {'title': 'Rice & Lentils', 'date': '5 Jan 2026', 'amount': 380.0},
    ];

    final double totalBazar = bazarItems.fold(
      0,
          (sum, item) => sum + (item['amount'] as double),
    );

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazar Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          /// TOTAL BAZAR CARD
          Container(
            margin: const EdgeInsets.all(AppStyles.spaceMedium),
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            decoration: AppStyles.coloredCardDecoration(AppColors.orange),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Bazar',
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppStyles.spaceXSmall),
                    Text(
                      '৳${totalBazar.toStringAsFixed(0)}',
                      style: AppStyles.heading2.copyWith(
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.orange,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          /// BAZAR LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppStyles.spaceMedium,
                0,
                AppStyles.spaceMedium,
                AppStyles.spaceMedium,
              ),
              itemCount: bazarItems.length,
              itemBuilder: (context, index) {
                final item = bazarItems[index];
                return _BazarItemCard(
                  title: item['title'],
                  date: item['date'],
                  amount: item['amount'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add bazar (manager only later)
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Bazar'),
      ),
    );
  }
}

/// BAZAR ITEM CARD
class _BazarItemCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  const _BazarItemCard({
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceSmall),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.orange,
              size: 24,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppStyles.spaceXSmall),
                Text(
                  date,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Text(
            '৳${amount.toStringAsFixed(0)}',
            style: AppStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
