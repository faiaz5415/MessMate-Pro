import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class MealTableScreen extends StatefulWidget {
  final bool isManager;

  const MealTableScreen({
    super.key,
    this.isManager = false,
  });

  @override
  State<MealTableScreen> createState() => _MealTableScreenState();
}

class _MealTableScreenState extends State<MealTableScreen> {
  /// MOCK DATA - Weekly Meal Plan
  final List<Map<String, dynamic>> weeklyMeals = [
    {
      'day': 'Saturday',
      'dayMeal': 'Fish Curry',
      'nightMeal': 'Chicken Masala',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Sunday',
      'dayMeal': 'Egg Curry',
      'nightMeal': 'Vegetable Mix',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Monday',
      'dayMeal': 'Beef Curry',
      'nightMeal': 'Dal & Rice',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Tuesday',
      'dayMeal': 'Fish Fry',
      'nightMeal': 'Chicken Korma',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Wednesday',
      'dayMeal': 'Mutton Curry',
      'nightMeal': 'Mixed Vegetables',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Thursday',
      'dayMeal': 'Prawn Curry',
      'nightMeal': 'Egg Bhuna',
      'icon': Icons.calendar_today,
    },
    {
      'day': 'Friday',
      'dayMeal': 'Chicken Roast',
      'nightMeal': 'Fish Curry',
      'icon': Icons.calendar_today,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Meal Table',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Weekly Plan',
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          if (widget.isManager)
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
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Edit feature coming soon'),
                      backgroundColor: AppColors.info,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                      ),
                    ),
                  );
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
              AppColors.primary.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppStyles.spaceMedium),

              /// INFO BANNER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.spaceLarge,
                ),
                child: ModernCard(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  color: AppColors.primary.withOpacity(0.05),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.restaurant_menu_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppStyles.spaceMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isManager
                                  ? 'Manager View'
                                  : 'This Week\'s Menu',
                              style: AppStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.isManager
                                  ? 'Tap edit to modify meals'
                                  : 'Saturday to Friday schedule',
                              style: AppStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// MEAL TABLE LIST
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppStyles.spaceLarge,
                    0,
                    AppStyles.spaceLarge,
                    AppStyles.spaceLarge,
                  ),
                  itemCount: weeklyMeals.length,
                  itemBuilder: (context, index) {
                    final meal = weeklyMeals[index];
                    final bool isToday = index == 0; // Mock "today"

                    return _MealDayCard(
                      day: meal['day'],
                      dayMeal: meal['dayMeal'],
                      nightMeal: meal['nightMeal'],
                      isToday: isToday,
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
/// MEAL DAY CARD
/// ------------------------------------------------------------
class _MealDayCard extends StatelessWidget {
  final String day;
  final String dayMeal;
  final String nightMeal;
  final bool isToday;

  const _MealDayCard({
    required this.day,
    required this.dayMeal,
    required this.nightMeal,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isToday ? AppColors.primary : AppColors.blue;

    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      color: isToday
          ? AppColors.primary.withOpacity(0.03)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// DAY HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: accentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (isToday) ...[
                const SizedBox(width: AppStyles.spaceSmall),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          /// DAY MEAL
          _MealRow(
            icon: Icons.wb_sunny_outlined,
            label: 'Day',
            meal: dayMeal,
            color: AppColors.orange,
          ),

          const SizedBox(height: AppStyles.spaceSmall),

          /// NIGHT MEAL
          _MealRow(
            icon: Icons.nightlight_outlined,
            label: 'Night',
            meal: nightMeal,
            color: AppColors.purple,
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// MEAL ROW (Day/Night)
/// ------------------------------------------------------------
class _MealRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String meal;
  final Color color;

  const _MealRow({
    required this.icon,
    required this.label,
    required this.meal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: AppStyles.spaceMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              meal,
              style: AppStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
