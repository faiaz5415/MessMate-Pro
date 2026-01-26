import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> mealHistory = [
      {'date': '20 Jan 2026', 'breakfast': 1, 'lunch': 1, 'dinner': 0},
      {'date': '19 Jan 2026', 'breakfast': 1, 'lunch': 1, 'dinner': 1},
      {'date': '18 Jan 2026', 'breakfast': 0, 'lunch': 1, 'dinner': 1},
      {'date': '17 Jan 2026', 'breakfast': 1, 'lunch': 0, 'dinner': 1},
      {'date': '16 Jan 2026', 'breakfast': 1, 'lunch': 1, 'dinner': 1},
    ];

    final int totalMeals = mealHistory.fold(
      0,
          (sum, day) =>
      sum +
          (day['breakfast'] as int) +
          (day['lunch'] as int) +
          (day['dinner'] as int),
    );

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Meals'),
      ),
      body: Column(
        children: [
          /// TOTAL MEALS CARD
          Container(
            margin: const EdgeInsets.all(AppStyles.spaceMedium),
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            decoration: AppStyles.coloredCardDecoration(AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Meals',
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppStyles.spaceXSmall),
                    Text(
                      totalMeals.toString(),
                      style: AppStyles.heading1.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                  ),
                  child: Icon(
                    Icons.restaurant_menu,
                    color: AppColors.blue,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          /// MEAL HISTORY
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppStyles.spaceMedium,
                0,
                AppStyles.spaceMedium,
                AppStyles.spaceMedium,
              ),
              itemCount: mealHistory.length,
              itemBuilder: (context, index) {
                final day = mealHistory[index];
                return _MealDayCard(
                  date: day['date'],
                  breakfast: day['breakfast'],
                  lunch: day['lunch'],
                  dinner: day['dinner'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add meal entry
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Meals'),
      ),
    );
  }
}

/// MEAL DAY CARD
class _MealDayCard extends StatelessWidget {
  final String date;
  final int breakfast;
  final int lunch;
  final int dinner;

  const _MealDayCard({
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  @override
  Widget build(BuildContext context) {
    final int total = breakfast + lunch + dinner;

    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spaceSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                ),
                child: Text(
                  '$total meals',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          Row(
            children: [
              _MealIndicator(
                label: 'Breakfast',
                count: breakfast,
                icon: Icons.breakfast_dining_outlined,
              ),
              const SizedBox(width: AppStyles.spaceMedium),
              _MealIndicator(
                label: 'Lunch',
                count: lunch,
                icon: Icons.lunch_dining_outlined,
              ),
              const SizedBox(width: AppStyles.spaceMedium),
              _MealIndicator(
                label: 'Dinner',
                count: dinner,
                icon: Icons.dinner_dining_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MealIndicator extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;

  const _MealIndicator({
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMeal = count > 0;

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: hasMeal ? AppColors.success : AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppStyles.caption.copyWith(
            color: hasMeal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
