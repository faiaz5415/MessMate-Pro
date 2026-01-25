class MealEntry {
  final bool dayOn;
  final double dayQty;
  final bool nightOn;
  final double nightQty;

  MealEntry({
    required this.dayOn,
    required this.dayQty,
    required this.nightOn,
    required this.nightQty,
  });

  double get totalMeal =>
      (dayOn ? dayQty : 0) + (nightOn ? nightQty : 0);
}

class MealCalculator {
  static double calculateUserTotalMeals(List<MealEntry> entries) {
    return entries.fold(
      0,
          (sum, entry) => sum + entry.totalMeal,
    );
  }

  static double calculateMealRate({
    required double totalMessCost,
    required double messTotalMeals,
  }) {
    if (messTotalMeals == 0) return 0;
    return totalMessCost / messTotalMeals;
  }
}
