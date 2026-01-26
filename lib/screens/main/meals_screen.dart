import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String _selectedMonth = 'January 2026';

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> mealHistory = [
      {
        'date': '21 Jan',
        'day': 'Today',
        'dayMeal': 1.0,
        'nightMeal': 1.0,
        'isLocked': false,
      },
      {
        'date': '20 Jan',
        'day': 'Yesterday',
        'dayMeal': 1.0,
        'nightMeal': 0.5,
        'isLocked': true,
      },
      {
        'date': '19 Jan',
        'day': 'Sunday',
        'dayMeal': 2.0,
        'nightMeal': 1.0,
        'isLocked': true,
      },
      {
        'date': '18 Jan',
        'day': 'Saturday',
        'dayMeal': 1.0,
        'nightMeal': 1.0,
        'isLocked': true,
      },
      {
        'date': '17 Jan',
        'day': 'Friday',
        'dayMeal': 0.5,
        'nightMeal': 1.0,
        'isLocked': true,
      },
    ];

    final double totalDayMeals = mealHistory.fold(
      0,
          (sum, item) => sum + (item['dayMeal'] as double),
    );
    final double totalNightMeals = mealHistory.fold(
      0,
          (sum, item) => sum + (item['nightMeal'] as double),
    );
    final double grandTotal = totalDayMeals + totalNightMeals;

    /// -------------------------------------------

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Meal Records'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AppColors.purple,
                ),
                const SizedBox(width: 6),
                Text(
                  _selectedMonth,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.purple,
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
            end: Alignment.center,
            colors: [
              AppColors.purple.withOpacity(0.03),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              /// HERO ZONE: Month Summary
              _HeroMealSummary(
                totalDayMeals: totalDayMeals,
                totalNightMeals: totalNightMeals,
                grandTotal: grandTotal,
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// SECTION HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Daily Records',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              /// FLOW ZONE: Daily Meal Cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
                  itemCount: mealHistory.length,
                  itemBuilder: (context, index) {
                    final record = mealHistory[index];
                    return _DailyMealCard(
                      date: record['date'],
                      day: record['day'],
                      dayMeal: record['dayMeal'],
                      nightMeal: record['nightMeal'],
                      isLocked: record['isLocked'],
                      onDayMealChanged: (value) {
                        // Handle day meal change
                      },
                      onNightMealChanged: (value) {
                        // Handle night meal change
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// HERO MEAL SUMMARY (Focus Zone)
/// ------------------------------------------------------------
class _HeroMealSummary extends StatelessWidget {
  final double totalDayMeals;
  final double totalNightMeals;
  final double grandTotal;

  const _HeroMealSummary({
    required this.totalDayMeals,
    required this.totalNightMeals,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
      padding: const EdgeInsets.all(AppStyles.spaceXLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.purple.withOpacity(0.08),
            AppColors.purple.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.purple.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          /// GRAND TOTAL
          Text(
            'Total Meals This Month',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            grandTotal.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: AppColors.purple,
              height: 1,
              letterSpacing: -2,
            ),
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          /// DAY & NIGHT BREAKDOWN
          Row(
            children: [
              Expanded(
                child: _MealTypeStat(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Day Meals',
                  count: totalDayMeals,
                  color: AppColors.orange,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.border,
              ),
              Expanded(
                child: _MealTypeStat(
                  icon: Icons.nightlight_outlined,
                  label: 'Night Meals',
                  count: totalNightMeals,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// MEAL TYPE STAT
class _MealTypeStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final double count;
  final Color color;

  const _MealTypeStat({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// ------------------------------------------------------------
/// DAILY MEAL CARD (Flow Zone)
/// ------------------------------------------------------------
class _DailyMealCard extends StatelessWidget {
  final String date;
  final String day;
  final double dayMeal;
  final double nightMeal;
  final bool isLocked;
  final ValueChanged<double> onDayMealChanged;
  final ValueChanged<double> onNightMealChanged;

  const _DailyMealCard({
    required this.date,
    required this.day,
    required this.dayMeal,
    required this.nightMeal,
    required this.isLocked,
    required this.onDayMealChanged,
    required this.onNightMealChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double totalDay = dayMeal + nightMeal;

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLocked
                ? AppColors.border.withOpacity(0.3)
                : AppColors.border.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            if (!isLocked)
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          children: [
            /// HEADER
            Row(
              children: [
                /// DATE BADGE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: AppColors.purple,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (isLocked)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Locked',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${totalDay.toStringAsFixed(1)} meals',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: AppColors.success,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: AppStyles.spaceMedium),

            /// MEAL SELECTORS
            Row(
              children: [
                Expanded(
                  child: _MealSelector(
                    icon: Icons.wb_sunny_outlined,
                    label: 'Day',
                    value: dayMeal,
                    color: AppColors.orange,
                    isLocked: isLocked,
                    onChanged: onDayMealChanged,
                  ),
                ),
                const SizedBox(width: AppStyles.spaceMedium),
                Expanded(
                  child: _MealSelector(
                    icon: Icons.nightlight_outlined,
                    label: 'Night',
                    value: nightMeal,
                    color: AppColors.blue,
                    isLocked: isLocked,
                    onChanged: onNightMealChanged,
                  ),
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
/// MEAL SELECTOR (Premium Quantity Picker)
/// ------------------------------------------------------------
class _MealSelector extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final Color color;
  final bool isLocked;
  final ValueChanged<double> onChanged;

  const _MealSelector({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isLocked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<double> quantities = [0, 0.5, 1, 1.5, 2];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          /// ICON & LABEL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// QUANTITY DISPLAY
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: color,
              height: 1,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 8),

          /// QUANTITY SELECTOR DOTS
          if (!isLocked)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: quantities.map((qty) {
                final bool isSelected = qty == value;
                return GestureDetector(
                  onTap: () => onChanged(qty),
                  child: Container(
                    width: isSelected ? 10 : 6,
                    height: isSelected ? 10 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: isSelected ? color : color.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
